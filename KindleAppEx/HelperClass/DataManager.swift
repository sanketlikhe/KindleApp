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
    
    // TODO: Changing completion handler's arguments to Result enum is pending
    func fetchKindleBooks(completion:@escaping (([Book]?, String?)->Void)) {
        webService.fetchBooks(kindleBooksUrl: kindleBooksUrl) { (result) in
            switch result{
            case .error(let errorString):
                completion(nil, errorString)
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do{
                    let bookDictinary = try decoder.decode([Book].self, from: data)
                    print(bookDictinary)
                    self.books = []
                    self.books=bookDictinary
                }catch let err {
                    print(err.localizedDescription)
                }
                completion(self.books, nil)
            }
        }

    }
    
    // TODO: Changing completion handler's arguments to Result enum is pending
    func downloadCoverImage(url: String, completion: @escaping ((UIImage?, String?)->Void)){
        webService.fetchCoverImage(url: url) { (result) in
            switch result{
            case .error(let errorString):
                completion(nil, errorString)
            case .success(let coverImage):
                guard let coverImage = coverImage else { return }
                DispatchQueue.main.async {
                    completion(coverImage, nil)
                }
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
