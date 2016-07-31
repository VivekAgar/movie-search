//
//  MovieSearchResultsPresenter.swift
//  movieSearch
//
//  Created by Satya on 30/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation

protocol MovieSearchResultsPresenterdelegate
{
    
    func onSearchResults(result : NSArray?)
    
    
    
}



class MovieSearchResultsPresenter : NSObject
{
    
    
    var delegate : MovieSearchResultsPresenterdelegate?
    
    
    init(delegate: MovieSearchResultsPresenterdelegate?) {
        
        self.delegate = delegate
        
    }
    
    
    func fetchSearchResultsWith(searchString : String, andType type:String )-> Void
    {
        
        
        OMDBAPIManager.retrieveMoviesFor(searchString, offset: "1", type: type,
                                         
                success: { (response)-> Void in
                 if let data = response as? NSDictionary{
                 self.parseSearchResult(data)
                    }
                 },
                 failure: {(error)->Void in
//                  self.onError(error!)
            })
    }
    
    func parseSearchResult(data : NSDictionary)
    {
        
        if let value = data["Response"] as? String {
         if value == "True"
         {
                let results: NSArray? = data["Search"] as? NSArray
                
                if let results = results {
                      let movies : NSArray = self.parseMovies(results)
                    dispatch_async(dispatch_get_main_queue()){
                        
                        self.delegate?.onSearchResults(movies)
                    }
                }
        }
         else{
            self.delegate?.onSearchResults(nil)
            }
        }
        
    }
    
    func parseMovies(moviesResponse: NSArray) -> NSArray {
        
        let moviesArray: NSMutableArray = NSMutableArray(capacity: moviesResponse.count)
        
        for movieResponse in moviesResponse {
            
            let movieDictionary: NSDictionary = movieResponse as! NSDictionary
            
            let movie: Movie? = Movie.init(dictionary: movieDictionary)
            
            if movie != nil {
                
                moviesArray.addObject(movie!)
            }
        }
        
        return moviesArray.copy() as! NSArray
    }
    
    
}