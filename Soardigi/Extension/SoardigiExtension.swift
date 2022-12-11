//
//  SoardigiExtension.swift
//  Soardigi
//
//  Created by Developer on 19/10/22.
//

import Foundation
import UIKit
import CoreLocation
extension UIViewController{
    @IBAction func onClickBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickClose(_ sender:UIButton){
        self.dismiss(animated: true
                    , completion: nil)
    }

//    func fetchCurrentLoction(onSuccess:@escaping()->()){
//        LocationManager.shared.setuplocationManager()
//        LocationManager.shared.updateLocations(didUpdateLocarionCompletion: { (locations:[CLLocation], manager:CLLocationManager) in
//            print("locations.last = \(String(describing: locations.last))")
//            currentLocation = locations.last
//            
//            onSuccess()
//        }) { (error:Error, manager:CLLocationManager) in
//      }
//        
//    }

}

//MARK:- EXTENSION FOR UIIMAGE
extension UIImage {
    var png: Data                 { return self.pngData()!       }
    var highestJPEG: Data        { return self.jpegData(compressionQuality: 1.0)!  }
    var highJPEG: Data           { return self.jpegData(compressionQuality: 0.75)! }
    var mediumJPEG: Data         { return self.jpegData(compressionQuality: 0.5)!  }
    var lowQualityJPEG: Data     { return self.jpegData(compressionQuality: 0.25)! }
    var lowestQualityJPEG:Data   { return self.jpegData(compressionQuality: 0.0)!  }
    
    func tint(with fillColor: UIColor) -> UIImage? {
        let image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        fillColor.set()
        image.draw(in: CGRect(origin: .zero, size: size))
        
        guard let imageColored = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        return imageColored
    }
    
    
    func imageWithImage(scaledToSize newSize:CGSize) -> UIImage?
    {
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage : UIImage? =  UIGraphicsGetImageFromCurrentImageContext()  //UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        let cgImage :CGImage = self.cgImage!
        let widthRatio  = newSize.width  / CGFloat(cgImage.width)
        let heightRatio = newSize.height / CGFloat(cgImage.height)
        let width:CGFloat =  newSize.width//CGFloat(cgImage.width / 2)
        var height:CGFloat = CGFloat(newSize.width)
        if widthRatio < heightRatio {
            height =  CGFloat(cgImage.height) * CGFloat(widthRatio)
            
        }
        
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)
        context?.interpolationQuality = .high
        context?.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width:width, height: height)))
        
        
        let scaledImage =  UIImage(cgImage: (context?.makeImage()!)!)
        
        return scaledImage
        
    }
}

//MARK:- Extension of the userdefaults
extension UserDefaults {
    class func NTDefault(setIntegerValue integer: Int , forKey key : String){
        UserDefaults.standard.set(integer, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func NTDefault(setObject object: Any , forKey key : String){
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func NTDefault(setValue object: Any , forKey key : String){
        UserDefaults.standard.setValue(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func NTDefault(setBool boolObject:Bool  , forKey key : String){
        UserDefaults.standard.set(boolObject, forKey : key)
        UserDefaults.standard.synchronize()
    }
    class func NTDefault(integerForKey  key: String) -> Int{
        let integerValue : Int = UserDefaults.standard.integer(forKey: key) as Int
        UserDefaults.standard.synchronize()
        return integerValue
    }
    class func NTDefault(objectForKey key: String) -> Any {
        let object  = UserDefaults.standard.object(forKey: key)
        if (object != nil) {
            UserDefaults.standard.synchronize()
            return object!
        }else{
            UserDefaults.standard.synchronize()
            return ""
        }
        
    }
    class func NTDefault(valueForKey  key: String) -> Any {
        let value  = UserDefaults.standard.value(forKey: key)
        if (value != nil) {
            UserDefaults.standard.synchronize()
            return value!
        }else{
            return ""
        }
        
    }
    class func NTDefault(boolForKey  key : String) -> Bool {
        let booleanValue : Bool = UserDefaults.standard.bool(forKey: key) as Bool
        UserDefaults.standard.synchronize()
        return booleanValue
    }
    
    class func NTDefault(removeObjectForKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    //Save no-premitive data
//    static func NTDefault( set codble:Mappable,forKey key:String){
//
//        if let encoded = codble.encoder() {
//            let defaults = UserDefaults.standard
//            defaults.set(encoded, forKey: key)
//            defaults.synchronize()
//        }
//    }
//    static func NTDefault<T>(_ type:T.Type ,forKey key:String)->T? where T:Mappable{
//        let defaults = UserDefaults.standard
//        if let storedData = defaults.object(forKey: key) as? Data {
//            let objectValue = storedData.decoder(T.self)
//            defaults.synchronize()
//            return objectValue
//        }
//        return nil
//    }
    
    class func NTDefault(setArchivedDataObject object: Any! , forKey key : String) {
        if (object != nil) {
            let data : NSData? = NSKeyedArchiver.archivedData(withRootObject: object) as NSData?
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
        
    }
    class func NTDefault(getUnArchiveObjectforKey key: String) -> Any {
        //var objectValue : Any?
        if  let storedData  = UserDefaults.standard.object(forKey: key) as? Data{
            
            let objectValue   =  NSKeyedUnarchiver.unarchiveObject(with: storedData)
            if (objectValue != nil)  {
                UserDefaults.standard.synchronize()
                return objectValue!
                
            }else{
                UserDefaults.standard.synchronize()
                return ""
                
            }
        }else{
            //objectValue = ""
            return ""
        }
    }
}
