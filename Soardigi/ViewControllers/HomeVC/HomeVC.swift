//
//  HomeVC.swift
//  Soardigi
//
//  Created by Developer on 13/11/22.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
class HomeVC: UIViewController {
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

}



enum FacebookPermissions:String {
    case email = "email"
    case publicProfile = "public_profile"
   
}



class FacebookLogin: NSObject {
    
    //MARK:- Facebook Login Methods
    func facebookLogin(withController:UIViewController,success:@escaping (_ finish: Bool,_ user:FacebookUserData) -> ()) {
        let fbLoginManager : LoginManager = LoginManager()
        //fbLoginManager.loginBehavior = LoginBehavior.browser
        fbLoginManager.logOut()
       
        fbLoginManager.logIn(permissions: [FacebookPermissions.publicProfile.rawValue,FacebookPermissions.email.rawValue,"pages_manage_posts","publish_video"], from: withController) { (result, error) in
            
            if error != nil{
                print(error.debugDescription)
                // Calling back to previous class if error occured
                success(false,error as! FacebookUserData)
                return
            }
            
            let FBLoginResult: LoginManagerLoginResult = result!
            
            if FBLoginResult.isCancelled{
                print("User cancelled the login process")
            }else if FBLoginResult.grantedPermissions.contains(FacebookPermissions.email.rawValue){
                self.getFBUserData(success: {(finish,user) in
                    if finish {
                        success(true,user)
                        return
                    }
                    success(false,user)
                })
            }
        }
        //success(true)
    }
    
    private func getFBUserData(success: @escaping(_ finished: Bool,_ user:FacebookUserData)-> ()){
        if (AccessToken.current != nil) {
            let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "id, first_name, last_name, email, gender,friends"])
            let connection = GraphRequestConnection()
            connection.add(graphRequest, completion: { (connection, result, error) -> Void in
                let data = result as! [String : AnyObject]
                let accessToken = AccessToken.current?.tokenString ?? ""
                let email = (data["email"] as? String) ?? ""
                let snsId = (data["id"] as? String) ?? ""
                let firstName = (data["first_name"] as? String) ?? ""
                let lastName = (data["last_name"] as? String) ?? ""
                let url = "https://graph.facebook.com/\(snsId)/picture?type=large&return_ssl_resources=1"
                let profilePicure = url
                let user = FacebookUserData(id: snsId, email: email, firstName: firstName, lastName: lastName, profilePic: profilePicure,fbAccessToken:accessToken)
                success(true,user)
            })
            connection.start()
        }
    }
    
    func logoutFB() {
        // let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        let loginManager = LoginManager()
        loginManager.logOut()
        
        URLCache.shared.removeAllCachedResponses()
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
}
struct FacebookUserData {
    var id :String! = ""
    var email:String! = ""
    var firstName:String! = ""
    var lastName:String! = ""
    var profilePic:String! = ""
    var fbAccessToken:String! =  ""
}
