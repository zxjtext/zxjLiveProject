//
//  APIManager.swift
//  zxjLive
//
//  Created by zxj on 2019/9/26.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
   var Alamofiremanager = Alamofire.SessionManager()
   var baseUrl = ""
    
   static let sharedInstance = APIManager()
    private override init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        Alamofiremanager = Alamofire.SessionManager(configuration: configuration)
        baseUrl = EnvironmentManager.sharedInstance.serverURL
        
    }
//    static let sharedSessionManager: Alamofire.SessionManager = {
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 10
//        return Alamofire.SessionManager(configuration: configuration)
//    }()
    //GET
    func GETRequest(API:String,parameters:[String : Any]? = nil,successfulCallback :  @escaping (_ result : Any) -> (),faileCallback : @escaping (_ result : Any) -> ()) -> Void {
        let urlstring = "\(baseUrl)\(API)"
        
        Alamofiremanager.request(urlstring, method: .get, parameters: parameters , encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            
             switch response.result {
                           
                       case .success(let value):
                           
                
                        successfulCallback(value)
                           
                       case .failure(let error):
                           
                           /**
                            *  失败
                            */
                        faileCallback(error)
                         
                           
                       }
           
            
        }
        
    }
    
    
    
    
    

}
