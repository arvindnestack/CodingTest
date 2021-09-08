//
//  APIManager.swift
//  CodingTest
//
//  Created by Arvind Tiwari on 08/09/21.
//

import Foundation
import Alamofire

@objcMembers class APIManager: NSObject {

    static let defaultManager = APIManager()
    var sessionManager: SessionManager!
    
    func getPosts(completionHandler: @escaping ([Any]?) -> Void) {
        
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        APIManager.defaultManager.jsonRequest(router: .getPosts) { (response) in
            if let response = response {
                completionHandler(response)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func jsonRequest(router: APIRouter, completionHandler: @escaping ([Any]?) -> Void) {

        sessionManager.request(router).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success:
               
                if let json = response.result.value as? [Any] {
                    completionHandler(json)
                }
                else {
                    completionHandler(nil)
                }
            case .failure( _):
                
                completionHandler(nil)
            }
        }
    }
}
