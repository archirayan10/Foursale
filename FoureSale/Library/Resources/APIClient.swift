//
//  APIClient.swift
//  Zenith
//
//  Created by Manish Surti on 13/02/2017.
//  Copyright © 2017 Archirayan. All rights reserved.
//

import UIKit

class APIClient{

    internal typealias CompletionBlock = (_ data:NSMutableDictionary?,_ error:NSError?) -> Void
    
    // MARK: - Main Common Methos
    private class func executePostAPICallWithMethod(method:String ,withParameters parameters:AnyObject?, callback:@escaping CompletionBlock) {
    
      //  let str = GlobleUrl.BASEURL + method
       /*
        request(method: POST,  str, parameters: parameters as? [String : AnyObject], encoding:.JSON, headers:nil)
            .responseJSON { (response) -> Void in
                debugPrint(response)
                switch response.result {
                case .Success(let JSON):
                    print("Success with JSON: \(JSON)")
                    print("Request failed with error: \(response.result.error)")
                    
                    let response = JSON as! NSMutableDictionary
                    
                    callback(data: response,error: nil)
                    break
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    callback(data: response.result.value as? NSMutableDictionary,error: error)
                    break
                }
        }*?

    }
    
    class func loginWithEmail(email stremail: String, andPassword password: String, completion:@escaping CompletionBlock) {
        let userinfo:Dictionary = ["email":stremail, "password":password]
        print(userinfo)
        self.executePostAPICallWithMethod(method: "employee_login.php?", withParameters:userinfo as AnyObject?) { (data, error) -> Void in
            completion(data,error)
        }
        
    }*/
    
    }
}
