//
//  apiConfig.swift
//  zxjLive
//
//  Created by zxj on 2019/9/27.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit

class apiConfig : NSObject{
    var homeDataUrl  =  "/home/v4/moreAnchor.ios"
    var giftDataUrl  =  "/pay/v4/giftList.ios"
    
    static let sharedInstance = apiConfig()
    
    private override init() {
        
    }
    
}
