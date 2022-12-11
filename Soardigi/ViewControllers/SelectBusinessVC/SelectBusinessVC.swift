//
//  SelectBusinessVC.swift
//  Soardigi
//
//  Created by Developer on 03/11/22.
//

import UIKit
import Kingfisher
class SelectBusinessVC: UIViewController {
    
    
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    @IBOutlet weak fileprivate var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.getBusineesCategory(sender: self, onSuccess: {
            self.collectionView.reloadData()
        }, onFailure: {
            
        })
        // Do any additional setup after loading the view.
    }
}

extension SelectBusinessVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 20) / 3
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessCategoryCVC", for: indexPath) as! BusinessCategoryCVC
        let data = homeViewModel.cellForRowAt(indexPath: indexPath)
        cell.titleLbl.text = data.name ?? ""
        cell.imageView.kf.setImage(with: URL(string: data.thumbnail ?? ""), placeholder: nil, options: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = homeViewModel.didSelectAt(indexPath: indexPath)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreateBusinessVC") as! CreateBusinessVC
        vc.heading = data.name ?? ""
        vc.id = data.id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
