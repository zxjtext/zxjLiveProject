//
//  EnvironmentManager.swift
//  zxjLive
//
//  Created by zxj on 2019/9/26.
//  Copyright © 2019 zxj. All rights reserved.
//



 import UIKit

 class EnvironmentManager: NSObject {
    var serverURL  =  "http://qf.56.com"
    static let sharedInstance = EnvironmentManager()
    private override init() {
        
    }

}
