//
//  Network.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Alamofire

class Network {
    /**
     通信状態を判定
     - Returns: true: オンライン, false: オフライン
     */
    static func onLineNetwork() -> Bool {
        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }
}
