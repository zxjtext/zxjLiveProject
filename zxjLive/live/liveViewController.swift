//
//  liveViewController.swift
//  zxjLive
//
//  Created by zxj on 2019/9/24.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit

 
class liveViewController: BaseViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    // MARK: 对外属性
    var homeType : HomeType!
    
    let reuseIdentifier : String = "homeCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        //布局
        let layout = NDCollectionView()
        self.collectionView.collectionViewLayout = layout
         //创建collectionView
        self.collectionView.dataSource = self as UICollectionViewDataSource
        self.collectionView.delegate = self as UICollectionViewDelegate
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(UINib.init(nibName: "homeCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        
        getHomeData()
        
    }
    
    
    
    
    func getHomeData() ->Void {
    
        SVProgressHUD.show()
        let parameters = ["type" : "0", "index" : "0", "size" : 48] as [String : Any];
       
        WRIFAPI.sharedInstance.getAPITest(url: apiConfig.sharedInstance.homeDataUrl, parameters: parameters, successful: { (response) in
            
            SVProgressHUD.dismiss()
                print(response)
          
              let array = ((response as! NSDictionary).value(forKey: "data"))
                  print(array ?? "")
              // 遍历方法1
              for item in (array as! Array<Any>) {
                  print (item)
                  let type = ((item as! NSDictionary).value(forKey: "type"))
                  if ((type as! NSNumber) == 2 ){
                      let model = AdModel.deserialize(from: (item as! NSDictionary))
                      print(model?.type! ?? "")
                      
                  }
               }
                },faile: { (response) in
                  SVProgressHUD.dismiss()
                    print(response)
                    
                })
      }

}



extension liveViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! homeCollectionViewCell
        cell.backgroundColor =  UIColor.init(red: CGFloat(Float(arc4random()%255)/255.0), green: CGFloat(Float(arc4random()%255)/255.0), blue: CGFloat(Float(arc4random()%255)/255.0), alpha: 1.0)
        let url = URL(string: "http://3.0.169.87/pxmart_upload/image/15658629254669854.jpeg")
        cell.iconImageView.kf.setImage(with: url)
        cell.titleLabel.text = "TEST"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let roomVc = liveDetaileViewController()
        navigationController?.pushViewController(roomVc, animated: true)
        
        
    }
    
    
}
