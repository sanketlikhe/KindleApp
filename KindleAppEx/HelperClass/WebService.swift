//
//  WebService.swift
//  KindleAppEx
//
//  Created by sanket rajendra likhe on 14/03/18.
//  Copyright © 2018 sanket rajendra likhe. All rights reserved.
//

import UIKit

enum WebserviceError: Error {
    case FoundNil(String)
    case ServerError(String)
}


enum Result<T> {
    case success(T?)
    case error(String)
}

class WebService: NSObject {
    
    func fetchBooks(kindleBooksUrl: String, completion : @escaping ((Result<Data>)->Void)) {
        print("Fetching Books...")
        guard let url = URL(string: kindleBooksUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("Fetching Book Completed")
            if error != nil {
                completion(Result.error("Failed to fetch external Json books"))
                return
            }
            if let data = data {
                completion(Result.success(data))
            }else{
                completion(Result.error("Data is nil"))
            }
        }.resume()
    }
    
    func fetchCoverImage(url: String, completion: @escaping ((Result<UIImage>)->Void)){
        guard let coverImageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: coverImageUrl) { (data, response, error) in
            if error != nil {
                completion(Result.error("Error fetching external image "))
            }
            guard let imageData = data else { return }
            let coverImage = UIImage(data: imageData)
            completion(Result.success(coverImage))
            }.resume()
    }
    
}
