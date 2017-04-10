//
//  ViewController.swift
//  testOmdb
//
//  Created by shrutesh sharma on 19/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation


/// Main Client used to hit the URL along with api calls
class APIClient {
    fileprivate let mainURL = "https://www.omdbapi.com"

    func sendRequest(_ request: Request, completionHandler: @escaping (Data?, Error) -> Void) {
        let urlString = "\(mainURL)/\(request.endPoint().addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
        //        let urlString = "\(mainURL)/\(request.endPoint())?&\(request.queryString().addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"

        if let url = URL(string: urlString) {
            var httpRequest = URLRequest(url: url)
            httpRequest.httpMethod = request.httpMethod().rawValue
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: httpRequest, completionHandler: { (data, response, error) in
                DispatchQueue.main.async(execute: {
                    () -> Void in
                    let customError = Error(error: error as NSError?)
                    completionHandler(data, customError)
                })
            })
            task.resume()
        }
    }
    
    func loadWithUrl(_ url: URL, completionHandler: @escaping (Data?, Error) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async(execute: {
                        let customError = Error(error: error as NSError?)
                        
                        completionHandler(data, customError)
                    })
                }
            }
        })
        
        task.resume()
    }
}
