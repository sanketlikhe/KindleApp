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

class WebService: NSObject {
    
    func fetchBooks(kindleBooksUrl: String, completion : @escaping ((Data?, Error?)->Void)) {
        print("Fetching Books...")
        guard let url = URL(string: kindleBooksUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("Fetching Book Completed")
            if error != nil {
                completion(nil, WebserviceError.ServerError("Failed to fetch external Json books"))
                return
            }
            if let data = data {
                completion(data, nil)
            }else{
                completion(nil, WebserviceError.FoundNil("Data is Nil."))
            }
        }.resume()
    }
    
    func fetchCoverImage(url: String, completion: @escaping ((UIImage?, Error?)->Void)){
        guard let coverImageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: coverImageUrl) { (data, response, error) in
            if error != nil {
                completion(nil, WebserviceError.ServerError("Error fetching external image "))
            }
            guard let imageData = data else { return }
            let coverImage = UIImage(data: imageData)
            completion(coverImage, nil)
            }.resume()
    }
    
}
