//
//  OMDBMdediaAPIManager.swift
//  movieSearch
//
//  Created by Satya on 31/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation
import UIKit
import ConvenientFileManager

class OMDBMediaAPIManager: NSObject {
    
    /**
     Retrieves a media asset from Omdb service.
     
     - parameter movie: Movie object with the information to retrieve the media asset.
     - parameter completion: completion callback returning media asset and Movie object.
     */
    class func retrieveOMDBMediaAsset(movie: Movie, completion:((imageMovie: Movie, mediaImage: UIImage?) -> Void)?) {
        
                let cacheDirectory: String = NSFileManager.cfm_cacheDirectoryPath()
                let absolutePath: String = cacheDirectory.stringByAppendingString(String(format: "/%@_image", movie.imdbID!))
        
                NSFileManager.cfm_fileExistsAtPath(absolutePath) { (fileExists: Bool) -> Void in
        
                    if fileExists {
        
                        let documentName: String = String(format: "%@_image", movie.imdbID!)
        
                        let imageData = NSFileManager.cfm_retrieveDataFromCacheDirectoryWithPath(documentName)
        
                        if var _ = imageData {
        
                            let image: UIImage = UIImage(data: imageData)!
        
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
                    else
                    {
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
                                                    let documentName: String = String(format: "%@_image", movie.imdbID!)
                    
                                                    NSFileManager.cfm_saveData(data, toCacheDirectoryPath: documentName)
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
        }
            }
}//end of class
