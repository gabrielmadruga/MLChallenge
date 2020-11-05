//
//  ProductDataSource.swift
//  MLChallenge
//
//  Created by Gabriel Madruga on 11/5/20.
//

import Foundation

struct ProductSearchItem {
    
    let title: String
    let price: Float
    let currency: String
    let thumbnail: String
    let permalink: String
}

extension ProductSearchItem {
    init?(json: [String: Any]) {
        guard let name = json["title"] as? String,
              let price = json["price"] as? Float,
              let currency = json["currency_id"] as? String,
              let thumbnail = json["thumbnail"] as? String,
              let permalink = json["permalink"] as? String
        else {
            return nil
        }
        
        self.title = name
        self.price = price
        self.currency = currency
        self.thumbnail = "https" + thumbnail.dropFirst(4)
        self.permalink = permalink
    }
}
