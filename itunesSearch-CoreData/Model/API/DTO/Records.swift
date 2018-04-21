//
//  Records.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

struct MapResponse: Codable {
    
    let records: [Record]
    
    struct Record: Codable {
        var trackId: Int?
        var artistName: String?
        var artworkUrl100: String?
        var trackName: String?
    }
    
    private enum CodingKeys: String, CodingKey {
        case records = "results"
    }
}
