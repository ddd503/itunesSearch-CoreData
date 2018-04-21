//
//  SearchParamsBuilder.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

class SearchParamsBuilder {
    /**
     リクエストパラメータを生成する
     */
    static func create(searchWord: String) -> [String: Any] {
        var params = [String: Any]()
        params["term"] = searchWord
        params["country"] = "JP"
        params["lang"] = "ja_jp"
        params["media"] = "music"
        return params
    }
}
