//
//  MovieDetailsPresenter.swift
//  movieSearch
//
//  Created by Satya on 31/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation

@objc protocol MovieDetailsPresenterdelegate
{
    
   func onMovieDetailsData(movie : Movie)
   optional func onErrorInSearch(error : NSError?)
   
   optional func showLoading()-> Void
   optional func hideLoadingAnimation() -> Void

}

class MovieDetailsPresenter : NSObject
{
    var delegate : MovieDetailsPresenterdelegate?
    
    init(delegate: MovieDetailsPresenterdelegate?) {
        
        self.delegate = delegate
    }

    func fetchMovieDetailsfor(movieID : String)
    {
        OMDBAPIManager.retrieveMovieDetails(movieID,
                  success: {(response)-> Void in
                          if let data = response as? NSDictionary{
                            self.parseMovieDetailsResponse(data)
                                }
                        },
                   failure: {(error)->Void in
                        self.onError(error!)
        })

        
    }
    
    func parseMovieDetailsResponse(datadict : NSDictionary) -> Void
    {
        if let value = datadict["Response"] as? String {
            if value == "True"
            {
            let movieDictionary: NSDictionary = datadict 
            
                let movie: Movie? = Movie.init(dictionary: movieDictionary)
                dispatch_async(dispatch_get_main_queue()){
                    
                    self.delegate?.onMovieDetailsData(movie!)
                }
            }
        }
        else{
            self.delegate?.onErrorInSearch!(nil)
        }
    }
    
    func onError(error : NSError?)
    {
       self.delegate?.onErrorInSearch!(error)
    }
    



}