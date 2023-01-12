//
//  AccountVC.swift
//  Soardigi
//
//  Created by Developer on 09/01/23.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
class AccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClickFacebookLogout(_ sender:UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        
    }
    
    @IBAction func onClickLogout(_ sender:UIButton) {
       showAlertWithTwoActions(sender: self, message: "Are you sure want to logout?", title: "Yes", secondTitle: "No", onSuccess: {
           
       }, onCancel: {
           
       })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
