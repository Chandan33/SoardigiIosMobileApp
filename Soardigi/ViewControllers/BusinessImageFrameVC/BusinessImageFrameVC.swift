//
//  BusinessImageFrameVC.swift
//  Soardigi
//
//  Created by Developer on 12/11/22.
//

import UIKit

class BusinessImageFrameVC: UIViewController {
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    fileprivate var ids:[FrameId] = [FrameId]()
    var id:String = ""
    @IBOutlet weak fileprivate var imageView:UIImageView!
    @IBOutlet weak fileprivate var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.getBusineesFrame(id:id,sender: self, onSuccess: {
            self.collectionView.reloadData()
        }, onFailure: {
      })
    }
    
    @IBAction func onClickNext(_ sender:UIButton) {
        
        
        let value =  homeViewModel.imageFrameResponseModel.filter{$0.selected == true}.map{$0.id ?? 0}
        //ids = value
        
        
        var values:[[String:String]] = [[String:String]]()
        
        for i in 0..<value.count {
            values.append(["id":"\(value[i])"])
        }
        
        homeViewModel.saveBusineesFrame(array: values, businessId: id, sender: self, onSuccess: {
            if let tabViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabViewController") as? TabViewController {
                self.present(tabViewController, animated: true, completion: nil)
            }
        }, onFailure: {
            
        })
    }
}



extension BusinessImageFrameVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 25) / 3
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.numberOfRowsFrame()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessFrameCVC", for: indexPath) as! BusinessFrameCVC
        let data = homeViewModel.cellForRowFrameAt(indexPath: indexPath)
       
        cell.imageViewCheck.image = data.selected ? UIImage(named: "check") : UIImage(named: "uncheck")
        cell.imageView.kf.setImage(with: URL(string: data.img_url ?? ""), placeholder: nil, options: nil) { result in
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
        
        let data = homeViewModel.didSelectFrameAt(indexPath: indexPath)
        homeViewModel.imageFrameResponseModel[indexPath.item].selected = !homeViewModel.imageFrameResponseModel[indexPath.item].selected
        imageView.kf.setImage(with: URL(string: data.img_url ?? ""), placeholder: nil, options: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        collectionView.reloadData()
        
    }
}

struct FrameId{
    var id:Int?
}
