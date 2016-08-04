//
//  MovieParser.swift
//  movieSearch
//
//  Created by Satya on 02/08/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation
class MovieParser : NSObject
{

    //MARK: - parseMovies
    
    /**
     Parse a movie response from the OMDB API.
     
     - parameter moviesResponse : a movie response from the OMDB API
     
     - returns: An array with Movie objects parsed.
     */

    func parseMovies(moviesResponse: NSArray) -> NSArray {
        
        let moviesArray: NSMutableArray = NSMutableArray(capacity: moviesResponse.count)
        
        for movieResponse in moviesResponse {
            
            let movieDictionary: NSDictionary = movieResponse as! NSDictionary
            
            let movie: Movie? = self.parseMovie(movieDictionary)
            
            if movie != nil {
                
                moviesArray.addObject(movie!)
            }
        }
        
        return moviesArray.copy() as! NSArray
    }

    //MARK: - ParseMovie
    
    /**
     Parse an single Movie response from the OMDB API.
     
     - parameter dictionary : a Movie response from the OMDB API
     
     - returns: A Movie object parsed.
     */
    
    func parseMovie(dictionary : NSDictionary) -> Movie
    {
        let movie : Movie = Movie.init()
        
        if let value = dictionary[Constant.TITLE_KEY] as? String {
            movie.title = value
        }
        if let value = dictionary[Constant.YEAR_KEY] as? String {
            movie.year = value
        }
        if let value = dictionary[Constant.RATED_KEY] as? String {
            movie.rated = value
        }
        if let value = dictionary[Constant.RELEASED_KEY] as? String {
            movie.released = value
        }
        if let value = dictionary[Constant.RUNTIME_KEY] as? String {
            movie.runTime = value
        }
        if let value = dictionary[Constant.GENERE_KEY] as? String {
            movie.genre = value
        }
        if let value = dictionary[Constant.DIRECTOR_KEY] as? String {
            movie.director = value
        }
        if let value = dictionary[Constant.WRITER_KEY] as? String {
            movie.writer = value
        }
        if let value = dictionary[Constant.ACTORS_KEY] as? String {
            movie.actors = value
        }
        if let value = dictionary[Constant.PLOT_KEY] as? String {
            movie.plot = value
        }
        if let value = dictionary[Constant.LANGUAGE_KEY] as? String {
            movie.language = value
        }
        if let value = dictionary[Constant.COUNTRY_KEY] as? String {
            movie.country = value
        }
        if let value = dictionary[Constant.AWARDS_KEY] as? String {
            movie.awards = value
        }
        if let value = dictionary[Constant.POSTER_URL_KEY] as? String {
            movie.posterUrl = value
        }
        if let value = dictionary[Constant.IMDB_RATING_KEY] as? String {
            movie.imdbRating = value
        }
        if let value = dictionary[Constant.IMDB_VOTES_KEY] as? String {
            movie.imdbVotes = value
        }
        if let value = dictionary[Constant.IMDB_ID_KEY] as? String {
            movie.imdbID = value
        }
        if let value = dictionary[Constant.METASCORE_KEY] as? String {
            movie.metascore = value
        }
        
        if let value = dictionary[Constant.TYPE_KEY] as? String {
            movie.type = value
        }
        
        return movie
    }
    

}
