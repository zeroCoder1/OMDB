//
//  Error.swift
//  testOmdb
//
//  Created by shrutesh sharma on 25/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation

class Error {
    fileprivate let error: NSError?
    
    var errorMessage: String? {
        get {
            if let error = error {
               return error.localizedDescription
            }
            return nil
        }
    }
    
    var hasError: Bool {
        get {
            return error != nil
        }
    }
    
    init(error: NSError?) {
        self.error = error
    }
}
