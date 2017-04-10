//
//  APIClient.swift
//  testOmdb
//
//  Created by shrutesh sharma on 19/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation

class SearchRequest: Request {
    
    fileprivate let term: String
    fileprivate let page: Int


    init(term: String, page: Int = 1) {
        self.term = term
        self.page = page
    }

    override func httpMethod() -> HTTPMethod {
        return .GET
    }

    override func endPoint() -> String {
        return "/?s=\(term)&page=\(page)"
    }
}
