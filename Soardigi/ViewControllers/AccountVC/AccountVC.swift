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

    @IBAction func onClickLogout(_ sender:UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        
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
