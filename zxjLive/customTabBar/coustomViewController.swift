//
//  coustomViewController.swift
//  zxjLive
//
//  Created by zxj on 2019/9/24.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit

class coustomViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        
    }
    
    // MARK: - 控制器的信息
    func setUpTabBar() {
        
        let demo1VC  = homeViewController()
        let demo2VC  = recommendedViewController()
        let demo3VC  = findViewController()
        let demo4VC  = profileViewController()
        
        creatTabbarView(viewController: demo1VC, image: "live-n", selectImage: "live-p", title: "直播")
        creatTabbarView(viewController: demo2VC, image: "ranking-n", selectImage: "ranking-p", title: "推荐")
        creatTabbarView(viewController: demo3VC, image: "found-n", selectImage: "found-p", title: "发现")
        creatTabbarView(viewController: demo4VC, image: "mine-n", selectImage: "mine-p", title: "我")
      
        
        self.tabBar.tintColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 13/255.0, alpha: 1)
        self.tabBar.isTranslucent = false
        
        self.viewControllers = [
            XMGNavigationController(rootViewController: demo1VC),
            XMGNavigationController(rootViewController: demo2VC),
            XMGNavigationController(rootViewController: demo3VC),
            XMGNavigationController(rootViewController: demo4VC)
        ];
        
    }
    
    // MARK: - TabBar里面的文字图片
    func creatTabbarView(viewController:UIViewController, image:NSString, selectImage:NSString, title:NSString) {
        // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        viewController.tabBarItem.image = UIImage(named: image as String)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImage as String)?.withRenderingMode(.alwaysOriginal)
        viewController.title = title as String
    }

}
