//
//  Router.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    /// ベースURL
    static let baseURLString = "https://itunes.apple.com"
    /// 検索API
    case searchAPI([String: Any])
    
    /**
     URLRequestにmethod, path, parametersをセットして返す
     */
    func asURLRequest() throws -> URLRequest {
        
        let (method, path, parameters): (HTTPMethod, String, [String: Any]) = {
            
            switch self {
            case .searchAPI(let params):
                return (.get, "/search", params)
            }
        }()
        
        if let url = URL(string: Router.baseURLString) {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            fatalError("urlがnilです。")
        }
    }
}
