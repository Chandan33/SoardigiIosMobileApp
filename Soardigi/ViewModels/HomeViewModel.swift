//
//  HomeViewModel.swift
//  Soardigi
//
//  Created by Developer on 03/11/22.
//

import UIKit

class HomeViewModel: NSObject {
    var businessCategoryResponseModel:[BusinessCategoryResponseModel] = [BusinessCategoryResponseModel]()
    
    var imageFrameResponseModel:[ImageFrameResponseModel] = [ImageFrameResponseModel]()
    var tokenId:String = ""
    func getLanguageList(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            showLoader(status: true)
            ServerManager.shared.httpPost(request:  "http://stgapi.soardigi.in/api/v1/" + API.kLanguageGet, params: nil,headers: ServerManager.shared.apiHeaders, successHandler: { (responseData:Data,status)  in
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(LanguageResponseMainModel.self) else{return}
                    
                    switch status{
                    case 200:
                        print(response)
                        onSuccess()
                        break
                    default:
                        
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    
    func getBusineesFrame(id:String = "",sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender) {
            showLoader(status: true)
        
            ServerManager.shared.httpPost(request:  "http://stgapi.soardigi.in/api/v1/image-frame-get?template=\(id)" , params: nil,headers: ServerManager.shared.apiHeaders, successHandler: { (responseData:Data,status)  in
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(BusinessFrameResponseMainModel.self) else{return}
                    
                    switch status{
                    case 200:
                        self.imageFrameResponseModel = response.frames ?? []
                        onSuccess()
                        break
                    default:
                        
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    
    func saveBusineesFrame(array: [[String:String]],businessId:String = "",sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender) {
            showLoader(status: true)
           
            let params:[String:Any] = ["business":businessId, "frames" :convertToJSONString(value: array) ?? ""]
            
            ServerManager.shared.httpPost(request:  "http://stgapi.soardigi.in/api/v1/save-business-frame" , params: params,headers: ServerManager.shared.apiHeaders, successHandler: { (responseData:Data,status)  in
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(SaveBusinessFrameResponseMainModel.self) else{return}
                    
                    switch status{
                    case 200:
                       
                        onSuccess()
                        break
                    default:
                        
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    func getBusineesCategory(search:String = "",sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender) {
            showLoader(status: true)
            
            let params:[String:Any] = ["search":search]
            
            ServerManager.shared.httpPost(request:  "http://stgapi.soardigi.in/api/v1/business-category" , params: params,headers: ServerManager.shared.apiHeaders, successHandler: { (responseData:Data,status)  in
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(BusinessCategoryResponseMainModel.self) else{return}
                    
                    switch status{
                    case 200:
                        self.businessCategoryResponseModel = response.businessCategoryResponseModel ?? []
                        onSuccess()
                        break
                    default:
                        
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    func saveLanguage(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            showLoader(status: true)
            //[["name":"tag1"],["name":"tag2"]]
            let value = [["id":"1"],["id":"14"]]
            
            let params:[String:Any] = ["languages":convertToJSONString(value: value) ?? ""]
            
            // http://stgapi.soardigi.in/api/v1/language-save
            ServerManager.shared.httpPost(request:  "http://stgapi.soardigi.in/api/v1/" + API.kLanguageSave, params: params,headers: ServerManager.shared.apiHeaders, successHandler: { (responseData:Data,status)  in
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(LanguageResponseMainModel.self) else{return}
                    
                    switch status{
                    case 200:
                        print(response)
                        onSuccess()
                        break
                    default:
                        
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
        }
    }
    
    func convertToJSONString(value: Any) -> String? {
            if JSONSerialization.isValidJSONObject(value) {
                do{
                    let data = try JSONSerialization.data(withJSONObject: value, options: [])
                    if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        return string as String
                    }
                }catch{
                }
            }
            return nil
        }
    
    
    
    func saveBusineesCategory(image:Any,category_id:String = "",name:String = "",email:String = "",code:String = "",mobile_no:String = "",alt_mobile_no:String = "",website:String = "",address:String = "",city:String = "",sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender) {
            
            if name.isEmpty{
                showAlertWithSingleAction(sender:sender, message: "Please enter Business Name")
            } else if email.isEmpty{
                showAlertWithSingleAction(sender:sender, message: "Please enter Business Email")
            } else if mobile_no.isEmpty{
                showAlertWithSingleAction(sender:sender, message: "Please enter Mobile Number")
            } else {
                showLoader(status: true)
                let array = self.set1(data: image)
                if array.isEmpty{
                     showLoader()
                    return
               }
                let params:[String:Any] = ["category_id":category_id,"name":name,"email":email,"code":code,"mobile_no":mobile_no,"alt_mobile_no":alt_mobile_no,"website":website,"address":address,"city":city]
                
                ServerManager.shared.httpUpload(request:  "http://stgapi.soardigi.in/api/v1/business-save" , params: params,headers: ServerManager.shared.apiHeaders,multipartObject: array, successHandler: { (responseData:Data,status)  in
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(BusinessSaveResponseMainModel.self) else{return}
                        
                        switch status{
                        case 200:
                            self.tokenId = response.token ?? ""
                            onSuccess()
                            break
                        default:
                            
                            
                            onFailure()
                            break
                        }
                    }
                }, failureHandler: { (error) in
                    DispatchQueue.main.async {
                        showLoader()
                        showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                        onFailure()
                    }
                })
            }
            
            
            
        }
    }

    fileprivate func set1(data:Any)->[MultipartData] {
           let dataFormate:DataFormate = .multipart
           let dataType:DataType!
           let uploadKey = "image"
           if let image = data as? UIImage {
               dataType = DataType.image(image: image, fileName: nil, uploadKey: uploadKey, formate: .jpeg(quality: .medium))
           }else if let url = data as? URL{
               dataType =  DataType.file(file: url, uploadKey: uploadKey)
           }else if let filePath = data as? String{
               dataType =  DataType.file(file: filePath, uploadKey: uploadKey)
           }else{
               return []
           }

           return [dataFormate.result(dataType: dataType) as! MultipartData]
       }
}


extension HomeViewModel {
    
    func numberOfRows() -> Int {
        businessCategoryResponseModel.count
    }
    
    func numberOfRowsFrame() -> Int {
        imageFrameResponseModel.count
    }
    
    func cellForRowFrameAt(indexPath:IndexPath) -> ImageFrameResponseModel {
        imageFrameResponseModel[indexPath.row]
    }
    
    func didSelectFrameAt(indexPath:IndexPath) -> ImageFrameResponseModel {
        imageFrameResponseModel[indexPath.row]
    }
    
    func cellForRowAt(indexPath:IndexPath) -> BusinessCategoryResponseModel {
        businessCategoryResponseModel[indexPath.row]
    }
    
    func didSelectAt(indexPath:IndexPath) -> BusinessCategoryResponseModel {
        businessCategoryResponseModel[indexPath.row]
    }
}
