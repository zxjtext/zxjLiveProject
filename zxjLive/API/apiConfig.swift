//
//  apiConfig.swift
//  zxjLive
//
//  Created by zxj on 2019/9/27.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit

class apiConfig : NSObject{
    var homeDataUrl  =  "v4/moreAnchor.ios"
    
    static let sharedInstance = apiConfig()
    
    private override init() {
        
    }
    
}
