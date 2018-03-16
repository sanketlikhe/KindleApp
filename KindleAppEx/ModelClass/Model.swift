//
//  Model.swift
//  KindleAppEx
//
//  Created by sanket rajendra likhe on 13/03/18.
//  Copyright © 2018 sanket rajendra likhe. All rights reserved.
//

import UIKit


// Model to store Book data
struct Book: Codable {
    let id: Int?
    let title: String?
    let author: String?
    let pages: [Page]?
    let coverImageUrl: String?
}


// Model to store Page Data
struct Page: Codable {
    let id: Int?
    let text: String?
}

