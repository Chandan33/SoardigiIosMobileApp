//
//  CreateBusinessVC.swift
//  Soardigi
//
//  Created by Developer on 06/11/22.
//

import UIKit

class CreateBusinessVC: UIViewController {
    @IBOutlet weak fileprivate var businessNameTF:CustomTextField!
    @IBOutlet weak fileprivate var emailTF:CustomTextField!
    @IBOutlet weak fileprivate var mobileTF:CustomTextField!
    @IBOutlet weak fileprivate var altMobileTF:CustomTextField!
    @IBOutlet weak fileprivate var websiteTF:CustomTextField!
    @IBOutlet weak fileprivate var addressTF:CustomTextField!
    @IBOutlet weak fileprivate var cityTF:CustomTextField!
    @IBOutlet weak fileprivate var headingLBL:UILabel!
    var heading:String = ""
    var id:Int = 0
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    @IBOutlet weak fileprivate var imgView:CustomImageView!
    var imagePicker = UIImagePickerController()
    fileprivate var selectedImageValue:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLBL.text = "Create Business - \(heading)"
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickSave(_ sender:UIButton) {
        homeViewModel.saveBusineesCategory(image: self.imgView.image!, category_id: "\(id)", name: businessNameTF.text ?? "", email: emailTF.text ?? "", code: "91", mobile_no: mobileTF.text ?? "", alt_mobile_no: altMobileTF.text ?? "", website: websiteTF.text ?? "", address: addressTF.text ?? "", city: cityTF.text ?? "", sender: self, onSuccess: {
            
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "BusinessImageFrameVC") as! BusinessImageFrameVC
            vc.id = self.homeViewModel.tokenId
            self.navigationController?.pushViewController(vc, animated: true)
        }, onFailure: {
            
        })
            

            
            
    }
    
    
    @IBAction func onClickChooseImage(_ sender:UIButton) {
        myImagePicker()
    }
    
   
}

extension CreateBusinessVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
     fileprivate func myImagePicker() {
         let pickerView = UIImagePickerController()
         pickerView.delegate = self
         pickerView.sourceType = .photoLibrary
         
         
         let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
         let gallaryAction = UIAlertAction(title: "Open Media Library", style: UIAlertAction.Style.default) {
             UIAlertAction in
             self.openGallery()
         }
         let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
             UIAlertAction in
         }
         
         if let popoverController = alert.popoverPresentationController {
             popoverController.sourceView = self.view
             popoverController.sourceRect =  CGRect.init(x: self.view.center.x + 50 , y: 75, width: 20, height: 20)
         }
         alert.addAction(gallaryAction)
         alert.addAction(cancelAction)
         alert.view.tintColor = CustomColor.appThemeColor
         self.present(alert, animated: true, completion: nil)
     }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self .present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera" , preferredStyle: .actionSheet)
            let secondAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction?) -> Void in
                
            })
            alert.addAction(secondAction)
            self.present(alert, animated: true)
        }
    }
    
    func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
       
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.imgView.image = selectedImage
            selectedImageValue = true
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.imgView.image = selectedImage
            selectedImageValue = true
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
