//
//  SearchMovie.swift
//  testOmdb
//
//  Created by shrutesh sharma on 19/03/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation

class SearchMovie {
    
    private var keyword:String = ""
    private var results:[MovieItem] = []
    private var totalResults:Int = 0
    private var currentPage:Int = 0
    private var searching:Bool = false
    
    init(keyword:String) {
        self.keyword = keyword
    }
    
    func getKeyword() -> String {
        return self.keyword
    }
    
    func getResults() -> [MovieItem] {
        return self.results
    }
    
    func getTotalResults() -> Int {
        return self.totalResults
    }
    
    func fecthNextPage(onCompletion:@escaping (Error?) -> Void) {
        
        if (!self.searching && (self.results.count == 0 || (self.currentPage * 10) <= self.results.count)) {
            self.searching = true
            DataManager.shared.searchMovieWithTerm(self.keyword, page: self.currentPage + 1, completionHandler: { (searchResult, movieItem, error) in
                self.searching = false
                
                if error?.errorMessage == nil {
                    if let movieItem = movieItem, let searchResult = searchResult {

                        if searchResult.response {
                            self.results += movieItem
                            self.currentPage += 1
                        }
                    }
                    onCompletion(error)
                }
            })
        }
    }
}
