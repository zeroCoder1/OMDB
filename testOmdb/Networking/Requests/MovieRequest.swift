//
//  APIClient.swift
//  testOmdb
//
//  Created by shrutesh sharma on 19/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation

class MovieRequest: Request {
    
    fileprivate let movieName: String

    init(movieName: String) {
        self.movieName = movieName
    }

    override func httpMethod() -> HTTPMethod {
        return .GET
    }

    override func endPoint() -> String {
        return "/?t=\(movieName)&plot=full"
    }
}
