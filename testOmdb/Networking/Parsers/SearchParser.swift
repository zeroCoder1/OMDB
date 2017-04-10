//
//  SearchParser.swift
//  testOmdb
//
//  Created by shrutesh sharma on 25/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation

class SearchParser: Parser {
    
    
    var searchResult    : [[String:AnyObject]] = [[:]]
    var totalResult     : Int = 0
    var response        : Bool = false
    
    var title       : String = ""
    var year        : String = ""
    var imdbid      : String = ""
    var type        : String = ""
    var poster      : String = ""

    override func scanObject(_ parsedJson: [String : AnyObject]) -> Any? {
        
        self.searchResult   = parsedJson["Search"] as? [[String : AnyObject]] ?? [[:]]
        self.totalResult    = parsedJson["totalResults"] as? Int ?? 0
        self.response       = parsedJson["Response"]?.boolValue ?? false
        
        var searchResultModel = [MovieItem]()
        
        for (_, movie) in self.searchResult.enumerated() {
            
            self.title          = movie["Title"] as? String ?? ""
            self.year           = movie["Year"] as? String ?? ""
            self.imdbid         = movie["imdbID"] as? String ?? ""
            self.type           = movie["Type"] as? String ?? ""
            self.poster         = movie["Poster"] as? String ?? ""
            
            searchResultModel.append(MovieItem(title: self.title,
                                               year: self.year,
                                               rated: "",
                                               released: "",
                                               runtime: "",
                                               genre: "",
                                               director: "",
                                               writer: "",
                                               actors: "",
                                               plot: "",
                                               language: "",
                                               country: "",
                                               awards: "",
                                               poster: self.poster,
                                               metascore: "",
                                               imdbrating: "",
                                               imdbvotes: "",
                                               imdbid: self.imdbid,
                                               type: self.type,
                                               response: self.response ))
        }
        
        return SearchResult(searchResult: self.searchResult, totalResult: self.totalResult, response: self.response, searchResultMovieItem: searchResultModel)
    }
}


struct SearchResult {
    
    var searchResult          : [[String:AnyObject]]
    var totalResult           : Int
    var response              : Bool
    var searchResultMovieItem : [MovieItem]?
}
