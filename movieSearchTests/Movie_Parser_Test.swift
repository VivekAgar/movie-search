//
//  Movie_Parser_Test.swift
//  movieSearch
//
//  Created by Satya on 04/08/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import XCTest
@testable import movieSearch
class Movie_Parser_Test: XCTestCase {
    
    //MARK: - Accessors
    
    var parser: MovieParser?
    
    // var moviesJSON: NSArray?
    var movieJSON : NSDictionary?
    var movieJSON1 : NSDictionary?
    var moviesJson : NSArray?
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
    var response : String?
    
    // MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        parser = MovieParser.init()
        
        title = "The Magical World of Harry Potter: The Unauthorized Story of J.K. Rowling"
        year = "2000"
        rated = "N/A"
        released = "N/A"
        runTime =  "50 min"
        genre = "Documentary"
        director = "Stephen Grant"
        writer = "Stephen Grant"
        actors = "J.K. Rowling"
        plot = "Everyone's favorite boy wizard is Harry Potter. By now, he and friends Ron, Hermoine and everyone else at Hogwarts are as magical to you as they are to the millions of fans around the world..."
        language = "English"
        country = "UK"
        awards = "N/A"
        posterUrl = "http://ia.media-imdb.com/images/M/MV5BMjE4MTM1NTUyNV5BMl5BanBnXkFtZTgwNDgyMzI2NTE@._V1_SX300.jpg"
        metascore = "N/A"
        imdbRating = "7.2"
        imdbVotes = "70"
        imdbID = "tt0308533"
        type = "movie"
        response = "True"
        
        
        movieJSON = [
            
            "Title":title!,
            "Year":year!,
            "Rated":rated!,
            "Released":released!,
            "Runtime":runTime!,
            "Genre":genre!,
            "Director":director!,
            "Writer":writer!,
            "Actors":actors!,
            "Plot":plot!,
            "Language":language!,
            "Country":country!,
            "Awards":awards!,
            "Poster":posterUrl!,
            "Metascore":metascore!,
            "imdbRating":imdbRating!,
            "imdbVotes": imdbVotes!,
            "imdbID":imdbID!,
            "Type":type!,
            "Response": response!
        ]
        
        
       movieJSON1 =  [
            
            "Title":"Harry Potter and the Deathly Hallows: Part 2",
            "Year":"2011",
            "Rated":"PG-13",
            "Released":"15 Jul 2011",
            "Runtime":"120 min",
            "Genre":"Adventure, Drama",
            "Director":"",
            "Writer":"",
            "Actors":"",
            "Plot":" short plot of Harry Potter",
            "Language":"English",
            "Country":"Uk",
            "Awards":"Nominated for 3 Oscars.",
            "Poster":"",
            "Metascore":"78",
            "imdbRating":"8.1",
            "imdbVotes": "535, 695",
            "imdbID":"tt1201607",
            "Type":"movie",
            "Response": "true"
            ]
        
        moviesJson = [movieJSON!,movieJSON1!]
        
        
        
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        parser = nil
        movieJSON = nil
        moviesJson = nil
        
        title = nil
        year = nil
        rated = nil
        released = nil
        runTime = nil
        genre = nil
        director = nil
        writer = nil
        actors = nil
        plot = nil
        language = nil
        country = nil
        awards = nil
        posterUrl = nil
        metascore = nil
        imdbRating = nil
        imdbVotes = nil
        imdbID = nil
        type = nil
        response = nil
        
        super.tearDown()
    }
    
    func test_parsemovie_newMovieObjectReturned() {
        
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertNotNil(movie, "A valid Movie object wasn't created");
    }
    
    func test_parseMovie_imdbID() {
        
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.imdbID! == imdbID!, String(format:"imdbID property was not set properly. Was set to: %@ rather than: %@", movie!.imdbID!, imdbID!));
    }
    
    func test_parseMovie_title() {
        
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.title! == title!, String(format:"title property was not set properly. Was set to: %@ rather than: %@", movie!.title!, title!));
    }
    
    func test_parseMovie_plot() {
        
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.plot! == plot!, String(format:"Movie Plot property was not set properly. Was set to: %@ rather than: %@", movie!.plot!, plot!));
    }
    
    func test_parseMovie_posterUrl() {
        
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.posterUrl! == posterUrl!, String(format:"posterUrl property was not set properly. Was set to: %@ rather than: %@", movie!.posterUrl!, posterUrl!))
    }
    
    
    
    func test_parseMovie_runtime(){
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.runTime! == runTime!, String(format:"runTime property was not set properly. Was set to: %@ rather than: %@", movie!.runTime!, runTime!));
        
    }
    
    func test_parseMovie_writers(){
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.writer! == writer!, String(format:"writer property was not set properly. Was set to: %@ rather than: %@", movie!.writer!, writer!));
    }
    
    func test_parseMovie_genre(){
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.genre! == genre!, String(format:"genre property was not set properly. Was set to: %@ rather than: %@", movie!.genre!, genre!));
        
    }
    
    func test_parseMovie_year() {
        let movie = parser?.parseMovie(movieJSON!)
        
        XCTAssertTrue(movie!.year! == year!, String(format:"year property was not set properly. Was set to: %@ rather than: %@", movie!.year!, year!))
    }
    
    func testPerformance_parseMovie() {
        self.measureBlock {
            // Put the code you want to measure the time of here.
            let movie = self.parser?.parseMovie(self.movieJSON!)
        }
    }
    
    //# - Mark
    
    // MARK: - moviesParser
    
    func test_parseMovies_newMoviesArrayReturned() {
        
        let movies = parser?.parseMovies(moviesJson!)
        
        XCTAssertNotNil(movies, "A valid Movies Array object wasn't created");
    }
    
    func test_parseMovies_count() {
        
        let movies = parser?.parseMovies(moviesJson!)
        let arrayCount = NSNumber(integer: movies!.count)
        let jsonCount = NSNumber(integer: moviesJson!.count)
        
        XCTAssertTrue(arrayCount == jsonCount, String(format:"Parsed count is wrong. Should be %@ rather than: %@", arrayCount , jsonCount));
    }
    
    func test_parseMovies_uniqueObjects() {
        
        let movies = parser?.parseMovies(moviesJson!)
        
        let firstObject = movies?.firstObject as! Movie
        let lastObject = movies?.lastObject as! Movie
        
        XCTAssertNotEqual(firstObject , lastObject, String(format:"Parsed movies without different objects: %@ and %@", firstObject , lastObject));
    }
    
    func test_parseMovies_orderFirstObjects() {
        
        let movies = parser?.parseMovies(moviesJson!)
        
        let firstObjectParsed = movies?.firstObject as! Movie
        let firstObject = moviesJson!.firstObject as! NSDictionary
        
        XCTAssertEqual(firstObjectParsed.imdbID, (firstObject["imdbID"] as! String), String(format:"Should have the same ID: %@", firstObjectParsed.imdbID!));
    }
    
    func test_parseMovies_orderLastObjects() {
        
        let movies = parser?.parseMovies(moviesJson!)
        
        let lastObjectParsed = movies?.lastObject as! Movie
        let lastObject = moviesJson!.lastObject as! NSDictionary
        
        XCTAssertEqual(lastObjectParsed.imdbID, (lastObject["imdbID"] as! String), String(format:"Should have the same ID: %@", lastObjectParsed.imdbID!));
    }

    
    
}
