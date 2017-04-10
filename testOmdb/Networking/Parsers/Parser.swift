//
//  Parser.swift
//  testOmdb
//
//  Created by shrutesh sharma on 25/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation

class Parser {
    
    fileprivate let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func parse() -> Any? {
        do {
          //  print(NSString(data:data, encoding:String.Encoding.utf8.rawValue) as! String)

            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

            if let object = object as? [String : AnyObject] {
                return scanObject(object)
            }
        } catch let caught as NSError {
            print(caught.description)
        }
        return nil
    }
    
    // To override. Factory method
    func scanObject(_ parsedJson: [String:AnyObject]) -> Any? {
        return nil
    }
}
