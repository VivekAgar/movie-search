//
//  MovieSearchResultParser.swift
//  movieSearch
//
//  Created by Satya on 02/08/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation
class  MovieSearchResultParser: NSObject {

    //MARK: - ParseSearchResult
    
    /**
    Parse a search response from the OMDB API.
     - parameter serverResponse: a search response from the OMDB API
     
     - returns: A MovieSearchResult objects parsed.
     */
    func parseSearchResult(serverResponse: NSDictionary) -> MovieSearchResult {
        
        let searchResult: MovieSearchResult = MovieSearchResult.init()

        if let value = serverResponse["Response"] as? String {
            if value == "True"
            {
                let results: NSArray? = serverResponse["Search"] as? NSArray
                let totalResultsCount  = Int((serverResponse["totalResults"] as? String)!)
                searchResult.totalsearchResults = totalResultsCount
                if let results = results {
                    let movies : NSArray = MovieParser().parseMovies(results)
                    searchResult.movies = movies
                }
            }
        }
        return searchResult
}




}