//
//  DataManager.swift
//  testOmdb
//
//  Created by shrutesh sharma on 25/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation
import UIKit

class DataManager {

    static let shared = DataManager()

    fileprivate let apiClient = APIClient()
    fileprivate let imageStorage = ImageDataManager()

    func fetchMovieWithId(_ name: String, completion: @escaping (MovieItem?, Error?) -> ()) {
        let request = MovieRequest(movieName: name)
        apiClient.sendRequest(request) { (data, error) in
            if let data = data {
                if let movie = MovieParser(data: data).parse() as? MovieItem {
                    self.loadPhotoForUrl(movie.poster) {
                        image, error in
                        
                        if let image = image {
                            if let data = UIImagePNGRepresentation(image) {
                                self.imageStorage.storeImageData(data, withFileName: String(movie.imdbid))
                            }
                        }
                        completion(movie, Error(error: nil))
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }
    

    func searchMovieWithTerm(_ term: String, page: Int = 1, completionHandler: @escaping (SearchResult?, [MovieItem]?, Error?) -> ()) {
        let request = SearchRequest(term: term, page: page)
        
        apiClient.sendRequest(request) { data, error in
            if let data = data {
                if let parsed = SearchParser(data: data).parse() as? SearchResult, let movieItem = parsed.searchResultMovieItem {

                    for (_ , movie) in movieItem.enumerated() {
                        
                        self.loadPhotoForUrl(movie.poster) {
                            image, error in
                            
                            if let image = image {
                                if let data = UIImagePNGRepresentation(image) {
                                    self.imageStorage.storeImageData(data, withFileName: String(movie.imdbid))
                                }
                            }
                        }
                    }
                    completionHandler(parsed, movieItem, Error(error: nil))
                }
            } else {
                completionHandler(nil, [], error)
            }
        }
    }
    
    func loadPhotoForUrl(_ urlString: String, completionHandler: @escaping (UIImage?, Error) -> ()) {
        if let url = URL(string: urlString) {
            apiClient.loadWithUrl(url, completionHandler: {
                (data, error) -> Void in
                var image: UIImage? = nil
                if let data = data {
                    image = UIImage(data: data)
                }
                completionHandler(image, error)
            })
        }
    }
    
    func posterImage(_ movie: MovieItem) -> UIImage? {
        if let image = imageStorage.fetchImageWithFileName(String(movie.imdbid)) {
            return image
        } else {
            return UIImage(named: "no_image.png")
        }
    }
    
}
