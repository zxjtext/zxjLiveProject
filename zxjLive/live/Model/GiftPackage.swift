//
//  GiftPackage.swift
//  XMGTV
//
//  Created by apple on 16/11/13.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class GiftPackage: BaseModel {
    var t : Int = 0
    var title : String = ""
    var list : [GiftModel] = [GiftModel]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            if let listArray = value as? [[String : Any]] {
                for listDict in listArray {
                    let giftModel = GiftModel()
                    giftModel.img2 = listDict["img2"] as! String
                    giftModel.coin = listDict["coin"] as! Int
                    giftModel.subject = listDict["subject"] as! String
                    list.append(giftModel)
                }
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}
