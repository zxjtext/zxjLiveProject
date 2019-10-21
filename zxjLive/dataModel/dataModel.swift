//
//  dataModel.swift
//  zxjLive
//
//  Created by zxj on 2019/9/26.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit
import HandyJSON

class AdModel:HandyJSON {
    
    var title:String?
    var type:String?
    var value:String?
    required init() {}
    
}


class HomeType:HandyJSON {
    var title : String = ""
    var type : Int = 0
    required init() {}
}
