//
//  ProductSearchItemService.swift
//  MLChallenge
//
//  Created by Gabriel Madruga on 11/15/20.
//

import Foundation

class ProductSearchItemService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func items(matching query: String, completion: @escaping ([ProductSearchItem]?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/sites/MLU/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]

        urlSession.dataTask(with: urlComponents.url!, completionHandler: { (data, response, error) in
            var items: [ProductSearchItem] = []

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
  
            if let results = json["results"] as? [Any] {
                for result in results {
                    if let item = ProductSearchItem(json: result as! [String : Any]) {
                        items.append(item)
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(items)
            }
        }).resume()
    }
}
