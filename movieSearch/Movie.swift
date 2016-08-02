//
//  Movie.swift
//  movieSearchDummy
//
//  Created by Satya on 28/07/16.
//  Copyright © 2016 slonkit. All rights reserved.
//

import Foundation
struct Constant
{
    static let TITLE_KEY = "Title"
    static let YEAR_KEY = "Year"
    static let RATED_KEY = "Rated"
    static let RELEASED_KEY = "Released"
    static let RUNTIME_KEY = "Runtime"
    static let GENERE_KEY = "Genre"
    static let DIRECTOR_KEY = "Director"
    static let WRITER_KEY = "Writer"
    static let ACTORS_KEY = "Actors"
    static let PLOT_KEY = "Plot"
    static let LANGUAGE_KEY = "Language"
    static let COUNTRY_KEY = "Country"
    static let AWARDS_KEY = "Awards"
    static let POSTER_URL_KEY = "Poster"
    static let METASCORE_KEY = "Metascore"
    static let IMDB_RATING_KEY = "imdbRating"
    static let IMDB_VOTES_KEY = "imdbVotes"
    static let IMDB_ID_KEY = "imdbID"
    static let TYPE_KEY = "Type"
    
    
    
    //
    static let kLoadingCellTag = 1001
    
}

class Movie : NSObject{
    
    var title : String?
    var year : String?
    var rated : String?
    var released : String?
    var runTime : String?
    var genre : String?
    var director : String?
    var writer : String?
    var actors : String?
    var plot : String?
    var language : String?
    var country : String?
    var awards : String?
    var posterUrl : String?
    var metascore : String?
    var imdbRating : String?
    var imdbVotes : String?
    var imdbID : String?
    var type : String?
    
    
    
    
    convenience init(dictionary : NSDictionary)
    {
    
        self.init()
        if let value = dictionary[Constant.TITLE_KEY] as? String {
            self.title = value
        }
        if let value = dictionary[Constant.YEAR_KEY] as? String {
            self.year = value
        }
        if let value = dictionary[Constant.RATED_KEY] as? String {
            self.rated = value
        }
        if let value = dictionary[Constant.RELEASED_KEY] as? String {
            self.released = value
        }
        if let value = dictionary[Constant.RUNTIME_KEY] as? String {
            self.runTime = value
        }
        if let value = dictionary[Constant.GENERE_KEY] as? String {
            self.genre = value
        }
        if let value = dictionary[Constant.DIRECTOR_KEY] as? String {
            self.director = value
        }
        if let value = dictionary[Constant.WRITER_KEY] as? String {
            self.writer = value
        }
        if let value = dictionary[Constant.ACTORS_KEY] as? String {
            self.actors = value
        }
        if let value = dictionary[Constant.PLOT_KEY] as? String {
            self.plot = value
        }
        if let value = dictionary[Constant.LANGUAGE_KEY] as? String {
            self.language = value
        }
        if let value = dictionary[Constant.COUNTRY_KEY] as? String {
            self.country = value
        }
        if let value = dictionary[Constant.AWARDS_KEY] as? String {
            self.awards = value
        }
        if let value = dictionary[Constant.POSTER_URL_KEY] as? String {
            self.posterUrl = value
        }
        if let value = dictionary[Constant.IMDB_RATING_KEY] as? String {
            self.imdbRating = value
        }
        if let value = dictionary[Constant.IMDB_VOTES_KEY] as? String {
            self.imdbVotes = value
        }
        if let value = dictionary[Constant.IMDB_ID_KEY] as? String {
            self.imdbID = value
        }
        
        if let value = dictionary[Constant.TYPE_KEY] as? String {
            self.type = value
        }
    
        
    }
    
    
    
    
}