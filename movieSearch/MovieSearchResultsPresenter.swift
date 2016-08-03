//
//  MovieSearchResultsPresenter.swift
//  movieSearch
//
//  Created by Satya on 30/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MovieSearchResultsPresenterdelegate
{
    
    func onSearchResults(result : NSArray?, totalresults : Int)
    func onNoResults()
    func onNoNetworkavailable()
    
    optional func onErrorInSearch(error : NSError?)
    func loadDetailviewController(movie : Movie)

    optional func showLoading(message :String )->Void
    optional func hideLoadingAnimation()->Void
    
}



class MovieSearchResultsPresenter : NSObject
{
    
    var delegate : MovieSearchResultsPresenterdelegate?
    
    init(delegate: MovieSearchResultsPresenterdelegate?) {
        
        self.delegate = delegate
        
    }
    
    
    
    func fetchSearchResultsWith(searchString : String, andType type:String, offset : String)-> Void {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (delegate.networkStatus != Reachability.NetworkStatus.NotReachable){
            OMDBAPIManager.retrieveMoviesFor(searchString, offset: offset, type: type,
                                         
                success: { (response)-> Void in
                 if let data = response as? NSDictionary{
                 self.parseSearchResult(data)
                    
                    }
                 },
                 failure: {(error)->Void in
                  self.onError(error!)
            })
        }
        else
        {
            self.onNoNetworkConnectivity()
        }
    }
    
    func parseSearchResult(data : NSDictionary) {
        
        let obj : MovieSearchResult = MovieSearchResultParser().parseSearchResult(data)
        dispatch_async(dispatch_get_main_queue()){
            if(obj.movies?.count > 0){
                self.delegate?.onSearchResults(obj.movies, totalresults : (obj.totalsearchResults!).integerValue )
            }
            else{
                self.delegate?.onNoResults()
            }
        }
    
    }
    
    func onError(error : NSError) {
        dispatch_async(dispatch_get_main_queue()){ self.delegate?.onErrorInSearch!(error) }
    }
    
    func loadDetailViewControllerFor( movie : Movie ){
        self.delegate?.loadDetailviewController(movie)
    }
    
    func onNoNetworkConnectivity() {
         dispatch_async(dispatch_get_main_queue()){
            self.delegate?.onNoNetworkavailable()
        }
    }
    
    
    
    
}