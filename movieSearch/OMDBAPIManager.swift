//
//  OMDBAPIManager.swift
//  movieSearch
//
//  Created by Satya on 30/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation
import UIKit
//import CoreOperation

class OMDBAPIManager: APIManager {
    
    //MARK: - Retrieve Search Result
    
    /**
     Retrieve Movies data from Omdb API.
     
     - parameter offset: the offset of data to be ask for.
     - parameter success: success callback to be called if the operation succed.
     - parameter failure: failure callback to be called if the operation fails.
     */
    class func retrieveMoviesFor(searchString : String, offset: String, type : String, success: NetworkingOnSuccess, failure: NetworkingOnFailure) {
        
        let urlString: String = String(format:"http://www.omdbapi.com/?s=%@&type=%@&page=%@", searchString, type, offset)

        var urlPath = NSURL(string: (urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))!)!
        print("URL : \(urlPath)")

        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithURL(urlPath){
            
            data, response, error -> Void in
            
            if (error != nil) {
                
                print(error!.localizedDescription)
            }
            
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? Dictionary<String, AnyObject>
                    {
                       // dispatch_async(dispatch_get_main_queue()){
                        success(result: jsonResult)
                        //}

                    }
            }
            catch let error as NSError{
                print(error.localizedDescription)
                failure(error: error)
            
            }
        }
        
        task.resume()
    }
    
    
    
    
    class func retrieveMovieDetails(movieID : String, success: NetworkingOnSuccess, failure: NetworkingOnFailure) {
        
        //http://www.omdbapi.com/?i
        let urlString: String = String(format:"http://www.omdbapi.com/?i=%@&plot=%@", movieID,"short")
        
        var urlPath = NSURL(string: (urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))!)!
        print("URL : \(urlPath)")
        
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithURL(urlPath){
            
            data, response, error -> Void in
            
            if (error != nil) {
                
                print(error!.localizedDescription)
            }
            
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? Dictionary<String, AnyObject>
                {
                    // dispatch_async(dispatch_get_main_queue()){
                    success(result: jsonResult)
                    //}
                    
                }
            }
            catch let error as NSError{
                print(error.localizedDescription)
                failure(error: error)
                
            }
        }
        
        task.resume()
    }

    
}
