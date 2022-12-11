//
//  CountryCodeCell.swift
//  Practina
//
//  Created by Chandan on 28/05/19.
//  Copyright © 2019 Chandan. All rights reserved.
//

import UIKit

class CountryCodeCell: UITableViewCell {
   
    @IBOutlet weak fileprivate var countryNameLBL: UILabel!
    @IBOutlet weak fileprivate var countryFlagImgView: UIImageView!
    var objCountryModel:CountryModel?{
        didSet{
            guard let countryName = objCountryModel?.name,let countryShortNameCode = objCountryModel?.phoneCode else{return}
           
            countryNameLBL.text =  "(\(countryShortNameCode)) \(countryName)"
            countryFlagImgView.image = objCountryModel?.flag
           
        }
    }
}
