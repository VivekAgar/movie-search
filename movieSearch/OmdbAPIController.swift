//
//  OmdbAPIController.swift
//  movieSearch
//
//  Created by Satya on 30/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

//
//  IMDBAPIController.swift
//  IMDBGuru
//
//  Created by alxcancado on 25/02/15.
//  Copyright (c) 2015 @alxcancado. All rights reserved.
//

import UIKit

protocol OmdbAPIControllerDelegate {
    
    func didFinishIMDBSearch(result: Dictionary<String, String>)
    
}

class OmdbAPIController {
    
    var delegate : OmdbAPIControllerDelegate?
    
    init(delegate: OmdbAPIControllerDelegate?) {
        
        self.delegate = delegate
        
    }
    
    func searchIMDB(forContent: String){
        
        var spacelessString = forContent.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //        println(spacelessString)
        
        if let foundString = spacelessString {
            
            var urlPath = NSURL(string: "http://www.omdbapi.com/?t=\(foundString)&tomatoes=true")
            
            var session = NSURLSession.sharedSession()
            
            var task = session.dataTaskWithURL(urlPath!){
                
                data, response, error -> Void in
                
                if (error != nil) {
                    
                    print(error!.localizedDescription)
                }
                
                // var jsonError : NSError?
                
                //                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as Dictionary<String, String>
                //
                //                if ((jsonError?) != nil){
                //
                //                    print(jsonError!.localizedDescription)
                //                }
                
                
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? Dictionary<String, String>
                    {
                        if let apiDelegate = self.delegate {
                            dispatch_async(dispatch_get_main_queue()){
                                
                                apiDelegate.didFinishIMDBSearch(jsonResult)
                                
                            }
                        }
                    }
                    
                }catch let error as NSError{
                    print(error.localizedDescription)
                    
                }
                
            }
            
            task.resume()
        }
    }
    
}
