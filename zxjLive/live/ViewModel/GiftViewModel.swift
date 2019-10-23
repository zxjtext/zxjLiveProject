//
//  GiftViewModel.swift
//  XMGTV
//
//  Created by apple on 16/11/13.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class GiftViewModel {
    lazy var giftlistData : [GiftPackage] = [GiftPackage]()
}

extension GiftViewModel {
    
   func loadGiftData(finishedCallback : @escaping () -> ()) {
        if giftlistData.count != 0 { finishedCallback() }
        SVProgressHUD.show()
        let parameters = ["type" : 0, "page" : 1, "rows" : 150] as [String : Any]
        WRIFAPI.sharedInstance.getAPITest(url: apiConfig.sharedInstance.giftDataUrl, parameters: parameters, successful: { (response) in

                    SVProgressHUD.dismiss()
                    print(response)
            guard let resultDict = response as? [String : Any] else { return }
            guard let dataDict = resultDict["message"] as? [String : Any] else { return }

                       for i in 0..<dataDict.count {
                           guard let dict = dataDict["type\(i+1)"] as? [String : Any] else { continue }
                           self.giftlistData.append(GiftPackage(dict: dict))
                       }

             print(self.giftlistData.count)
            
           // self.giftlistData = self.giftlistData.filter({ return $0.t != 0 }).sorted(by: { return $0.t > $1.t })
            
            
                print(self.giftlistData.count)
            
            
                        finishedCallback()

                       },faile: { (response) in
                        
                         SVProgressHUD.dismiss()
                         print(response)
                        finishedCallback()
                  })
    

    }
        
}
        
    
    
