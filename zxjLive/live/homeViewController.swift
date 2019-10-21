//
//  homeViewController.swift
//  zxjLive
//
//  Created by zxj on 2019/10/17.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
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

// MARK:- 设置UI界面内容
extension homeViewController {
    fileprivate func setupUI() {
       // setupNavigationBar()
        setupContentView()
    }
    
    
    fileprivate func setupContentView() {
        // 1.获取数据
        let homeTypes = loadTypesData()
        
        // 2.创建主题内容
        let style = HYTitleStyle()
        style.isScrollEnable = true
        let pageFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kScreenH - kNavigationBarH - kStatusBarH - 44)
        /*
        var titles = [String]()
        for type in homeTypes {
            titles.append(type.title)
        }
        */
        
        
//        let titles = homeTypes.map { (type : HomeType) -> String in
//            return type.title
//        }
        
        let titles = homeTypes.map({ $0.title })
        var childVcs = [AnchorViewController]()
        for type in homeTypes {
            let anchorVc = AnchorViewController()
            anchorVc.homeType = type
            childVcs.append(anchorVc)
        }
        let pageView = HYPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }
    
    fileprivate func loadTypesData() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var tempArray = [HomeType]()
        for dict in dataArray {
            let homeModel = HomeType()
            homeModel.title = dict["title"] as! String
            tempArray.append(homeModel)
        }
        return tempArray
    }
}


// MARK:- 事件处理
extension homeViewController {
    @objc fileprivate func collectItemClick() {
        print("弹出收藏控制器")
    }
}



