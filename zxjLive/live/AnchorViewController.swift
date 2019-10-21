//
//  AnchorViewController.swift
//  XMGTV
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class AnchorViewController: UIViewController {
    
    private let kEdgeMargin : CGFloat = 8
    // MARK: 对外属性
    var homeType : HomeType!
    let reuseIdentifier : String = "homeCollectionViewCell"
    
    // MARK: 定义属性
    fileprivate lazy var collectionView : UICollectionView = {
         let layout = NDCollectionView()
        layout.sectionInset = UIEdgeInsets(top: kEdgeMargin, left: kEdgeMargin, bottom: kEdgeMargin, right: kEdgeMargin)
        layout.minimumLineSpacing = kEdgeMargin
        layout.minimumInteritemSpacing = kEdgeMargin
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "homeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(index: 0)
    }
    
}


// MARK:- 设置UI界面内容
extension AnchorViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

extension AnchorViewController {
    fileprivate func loadData(index : Int) {
        
        self.collectionView.reloadData()
//        homeVM.loadHomeData(type: homeType, index : index, finishedCallback: {
//            self.collectionView.reloadData()
//        })
    }
}

extension AnchorViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
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
