//
//  MovieParser.swift
//  testOmdb
//
//  Created by shrutesh sharma on 25/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation


/// Parses the movie and returns the movie model
class MovieParser: Parser {
    
    var title       : String = ""
    var year        : String = ""
    var rated       : String = ""
    var released    : String = ""
    var runtime     : String = ""
    var genre       : String = ""
    var director    : String = ""
    var writer      : String = ""
    var actors      : String = ""
    var plot        : String = ""
    var language    : String = ""
    var country     : String = ""
    var awards      : String = ""
    var poster      : String = ""
    var metascore   : String = ""
    var imdbrating  : String = ""
    var imdbvotes   : String = ""
    var imdbid      : String = ""
    var type        : String = ""
    var response    : Bool = false

    
    /// Assing the model to the parsed JSON
    ///
    /// - Parameter parsedJson: Parsed Json
    /// - Returns: The model assigned with they are keys
    override func scanObject(_ parsedJson: [String:AnyObject]) -> Any? {
        self.title          = parsedJson["Title"] as? String ?? ""
        self.year           = parsedJson["Year"] as? String ?? ""
        self.rated          = parsedJson["Rated"] as? String ?? ""
        self.released       = parsedJson["Released"] as? String ?? ""
        self.runtime        = parsedJson["Runtime"] as? String ?? ""
        self.genre          = parsedJson["Genre"] as? String ?? ""
        self.director       = parsedJson["Director"] as? String ?? ""
        self.writer         = parsedJson["Writer"] as? String ?? ""
        self.actors         = parsedJson["Actors"] as? String ?? ""
        self.plot           = parsedJson["Plot"] as? String ?? ""
        self.language       = parsedJson["Language"] as? String ?? ""
        self.country        = parsedJson["Country"] as? String ?? ""
        self.awards         = parsedJson["Awards"] as? String ?? ""
        self.poster         = parsedJson["Poster"] as? String ?? ""
        self.metascore      = parsedJson["Metascore"] as? String ?? ""
        self.imdbrating     = parsedJson["imdbRating"] as? String ?? ""
        self.imdbvotes      = parsedJson["imdbVotes"] as? String ?? ""
        self.imdbid         = parsedJson["imdbID"] as? String ?? ""
        self.type           = parsedJson["Type"] as? String ?? ""
        self.response       = parsedJson["Response"]?.boolValue ?? false

        return MovieItem(title: self.title,
                         year: self.title,
                         rated: self.rated,
                         released: self.released,
                         runtime: self.runtime,
                         genre: self.genre,
                         director: self.director,
                         writer: self.writer,
                         actors: self.actors,
                         plot: self.plot,
                         language: self.language,
                         country: self.country,
                         awards: self.awards,
                         poster: self.poster,
                         metascore: self.metascore,
                         imdbrating: self.imdbrating,
                         imdbvotes: self.imdbvotes,
                         imdbid: self.imdbid,
                         type: self.type,
                         response: self.response )
    }
}


/// Model for a movie item
struct MovieItem {
    
    var title       : String
    var year        : String
    var rated       : String
    var released    : String
    var runtime     : String
    var genre       : String
    var director    : String
    var writer      : String
    var actors      : String
    var plot        : String
    var language    : String
    var country     : String
    var awards      : String
    var poster      : String
    var metascore   : String
    var imdbrating  : String
    var imdbvotes   : String
    var imdbid      : String
    var type        : String
    var response    : Bool
}
