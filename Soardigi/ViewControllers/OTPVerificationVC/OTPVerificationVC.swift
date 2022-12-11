//
//  OTPVerificationVC.swift
//  Soardigi
//
//  Created by Developer on 20/10/22.
//

import UIKit

class OTPVerificationVC: UIViewController {
    @IBOutlet weak fileprivate var tf1:CustomTextField!
    @IBOutlet weak fileprivate var tf2:CustomTextField!
    @IBOutlet weak fileprivate var tf3:CustomTextField!
    @IBOutlet weak fileprivate var tf4:CustomTextField!
    @IBOutlet weak fileprivate var tf5:CustomTextField!
    @IBOutlet weak fileprivate var tf6:CustomTextField!
    var email:String = ""
    var name:String = ""
    var phone:String = ""
    var code:String = ""
    var isFromLogin:Bool = false
    var selectedType:SelectedType = .mobile
    
    fileprivate var userViewModel:UserViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
                 
        
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
    
    @IBAction fileprivate func textFieldDidChanged(_ sender: CustomTextField) {
        let text = sender.text
        if text?.utf16.count == 1{
            switch sender{
            case tf1:
                tf2.becomeFirstResponder()
            case tf2:
                tf3.becomeFirstResponder()
            case tf3:
                tf4.becomeFirstResponder()
            case tf4:
                tf5.becomeFirstResponder()
            case tf5:
                tf6.becomeFirstResponder()
            case tf6:
                tf6.resignFirstResponder()
            default:
                break
            }
            
            
        }
        else if text?.utf16.count == 0{
            switch sender{
            case tf1:
                tf1.resignFirstResponder()
            case tf2:
                tf1.becomeFirstResponder()
            case tf3:
                tf2.becomeFirstResponder()
            case tf4:
                tf3.becomeFirstResponder()
            case tf5:
                tf4.becomeFirstResponder()
            case tf6:
                tf5.becomeFirstResponder()
            default:
                break
            }
           
        }
        else  {
            
        }
    }
    
    @IBAction func onClickVerification(_ sender: UIButton) {
        
        let data = tf1.text!  + tf2.text!  +  tf3.text!  + tf4.text! + tf5.text! + tf6.text!
        if isFromLogin {
            userViewModel.otpVerification(type:selectedType.value ?? "",isFromLogin:isFromLogin, phone: phone, code: code, sender: self, email: email, otp: data, onSuccess: { [self] in
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "ChooseLanguageVC") as! ChooseLanguageVC
                
                self.navigationController?.pushViewController(vc, animated: true)
            }, onFailure: {
                
            })
        } else {
            userViewModel.otpVerification(name: name, phone: phone, code: code, sender: self, email: email, otp: data, onSuccess: {
                showAlertWithSingleAction1(sender: self, message: "Email Verified Successfully", onSuccess: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
            }, onFailure: {
                
            })
        }
        
    }
    
//    @IBAction func onClickResend(_ sender: UIButton) {
//        userViewModel.resendOtp(sender: self, email: email, onSuccess: {
//            showAlertWithSingleAction1(sender: self, message: "OTP sent Successfully", onSuccess: {
//                
//            })
//        }, onFailure: {
//            
//        })
//    }

}
