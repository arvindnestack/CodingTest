//
//  APIRouter.swift
//  CodingTest
//
//  Created by Arvind Tiwari on 08/09/21.
//


import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getPosts
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            
            switch self {
                
            case .getPosts:
                 return .get
                
            }
        }
        
        let params: ([String: Any]?) = {
            
            switch self {
           
            case .getPosts:
                return nil
                
                
            }
        }()
        
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String!
            
            switch self {
                
            case .getPosts:
                relativePath = "posts"
                
            }
            
            var baseUrl = "https://jsonplaceholder.typicode.com/"
            let urlString = baseUrl.appending(relativePath)
            var url: URL!
            
            if let urlwithPercent = urlString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                url = URL(string: urlwithPercent)!
            }
            
            return url
        }()
        
        var shouldAuthenticate: Bool {
            
            switch self {
            default:
                return false
            }
        }
        
        let encoding: ParameterEncoding = {
            
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var contentType: String  {
            
            switch self {
          
            default:
                return "application/json"
            }
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        return try encoding.encode(urlRequest, with: params)
    }
}

