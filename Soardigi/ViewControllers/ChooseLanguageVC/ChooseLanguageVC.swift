//
//  ChooseLanguageVC.swift
//  Soardigi
//
//  Created by Developer on 01/11/22.
//

import UIKit

class ChooseLanguageVC: UIViewController {
    
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.getLanguageList(sender: self, onSuccess: {
            
        }, onFailure: {
            
        })
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
    
    
    @IBAction func onClickEnglish(_ sender: CustomButton) {
        sender.backgroundColor = sender.isSelected ? .white : CustomColor.customYellowColor
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func onClickHindi(_ sender: CustomButton) {
        sender.backgroundColor = sender.isSelected ? .white : CustomColor.customYellowColor
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func onClickApply(_ sender: UIButton) {
        homeViewModel.saveLanguage(sender: self, onSuccess: {
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "SelectBusinessVC") as! SelectBusinessVC
          
            self.navigationController?.pushViewController(vc, animated: true)
        }, onFailure: {
            
        })
    }
}
