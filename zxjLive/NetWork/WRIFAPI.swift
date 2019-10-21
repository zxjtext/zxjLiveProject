//
//  WRIFAPI.swift
//  zxjLive
//
//  Created by zxj on 2019/9/26.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit

class WRIFAPI: NSObject {
    
    static let sharedInstance = WRIFAPI()
    private override init() {
        
    }
    func getAPITest(url:String,parameters:[String : Any]? = nil,successful : @escaping (_ result : Any) -> (),faile : @escaping (_ result : Any) -> ()) -> Void {
        
        APIManager.sharedInstance.GETRequest(API: url, parameters:parameters, successfulCallback: { (response) in
            successful(response)
        }, faileCallback: { (response) in
            faile(response)
        })
        
        
    }
    
    
    

}
