//
//  APIClient.swift
//  testOmdb
//
//  Created by shrutesh sharma on 19/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation

class PopularRequest: Request {
    override func httpMethod() -> HTTPMethod {
        return .GET
    }

    override func parameters() -> [String:AnyObject]? {
        return super.parameters()
    }

    override func endPoint() -> String {
        return super.endPoint()
    }

    override func path() -> String {
        return super.path()
    }

    override func queryString() -> String {
        return super.queryString()
    }

}
