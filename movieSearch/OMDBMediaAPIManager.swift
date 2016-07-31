//
//  OMDBMdediaAPIManager.swift
//  movieSearch
//
//  Created by Satya on 31/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation

import UIKit

//import CoreNetworking
//import CoreOperation

enum MediaAspectRatio: String {
    
    case Portrait = "portrait_incredible"
    case Camera = "camera"
}

class OMDBMediaAPIManager: NSObject {
    
    /**
     Retrieves a media asset from Omdb service.
     
     - parameter movie: Movie object with the information to retrieve the media asset.
     - parameter completion: completion callback returning media asset and Movie object.
     */
    class func retrieveOMDBMediaAsset(movie: Movie, completion:((imageMovie: Movie, mediaImage: UIImage?) -> Void)?) {
        

                if let thumbnailPath = movie.posterUrl {
                    
                        let urlString: String = String(format: "%@", thumbnailPath)
                        let urlPath = NSURL(string: urlString)
                        let session = NSURLSession.sharedSession()
                        let task = session.dataTaskWithURL(urlPath!){
                        
                        data, response, error -> Void in
                        
                        if (error != nil) {
                            
                            print(error!.localizedDescription)
                        }
                        
                            if (data != nil) {

                                let image: UIImage = UIImage(data: data!)!

                                if let _ = completion {

                                    completion!(imageMovie: movie, mediaImage: image)
                                }

                            }
                            else
                            {
                                if let _ = completion {

                                    completion!(imageMovie: movie, mediaImage: nil)
                                }
                            }

                    }
                    
                    task.resume()
                }

    }
}//end of class
