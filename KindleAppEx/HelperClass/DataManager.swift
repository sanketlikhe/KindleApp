//
//  DataManager.swift
//  KindleAppEx
//
//  Created by sanket rajendra likhe on 14/03/18.
//  Copyright © 2018 sanket rajendra likhe. All rights reserved.
//

import UIKit

let kindleBooksUrl = "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json"

class DataManager: NSObject {
    
    var books: [Book] = []
    private let webService: WebService = WebService()
    
    func fetchKindleBooks(completion:@escaping (([Book]?, Error?)->Void)) {
        webService.fetchBooks(kindleBooksUrl: kindleBooksUrl) { [weak self](data, error) in
            if let serverError = error {
                completion(nil, serverError)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do{
                let bookDictinary = try decoder.decode([Book].self, from: data)
                print(bookDictinary)
                self?.books = []
                self?.books=bookDictinary
            }catch let err {
                print(err.localizedDescription)
            }
            
            completion(self?.books, nil)
        }
    }
    
    func downloadCoverImage(url: String, completion: @escaping ((UIImage?, Error?)->Void)){
        webService.fetchCoverImage(url: url) { (coverImage, error) in
            if error != nil {
                completion(nil, error)
            }
            guard let coverImage = coverImage else { return }
            DispatchQueue.main.async {
                completion(coverImage, nil)
            }
        }
    }
    
    func getPagesForBook(book: Book) -> [Page]{
        if let pages = book.pages{
            return pages
        }else{
            return []
        }
    }
    
}
