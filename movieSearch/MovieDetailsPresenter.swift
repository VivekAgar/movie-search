//
//  MovieDetailsPresenter.swift
//  movieSearch
//
//  Created by Satya on 31/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MovieDetailsPresenterdelegate
{
    
   func onMovieDetailsData(movie : Movie)
   func onNoResults()
   func onNoNetworkavailable()
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
       
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (delegate.networkStatus != Reachability.NetworkStatus.NotReachable){
            
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
        else {
            self.onNoNetworkConnectivity()
        }
        
    }
    
    func parseMovieDetailsResponse(datadict : NSDictionary) -> Void
    {
        if let value = datadict["Response"] as? String {
            if value == "True"
            {
            let movieDictionary: NSDictionary = datadict 
            
                let movie: Movie? = MovieParser().parseMovie(movieDictionary)
                dispatch_async(dispatch_get_main_queue()){
                    
                    self.delegate?.onMovieDetailsData(movie!)
                }
            }
            else{
                dispatch_async(dispatch_get_main_queue()){
                    self.delegate?.onNoResults()
                }
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue()){
                self.delegate?.onErrorInSearch!(nil)
            }
        }
    }
    
    func onError(error : NSError?)
    {
       dispatch_async(dispatch_get_main_queue()){
         self.delegate?.onErrorInSearch!(error)
        }
    }
    
    func onNoNetworkConnectivity() {
        dispatch_async(dispatch_get_main_queue()){
            self.delegate?.onNoNetworkavailable()
        }
    }



}