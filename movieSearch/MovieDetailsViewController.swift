//
//  MovieDetailsViewController.swift
//  movieSearch
//
//  Created by Satya on 31/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController , MovieDetailsPresenterdelegate{
    
    
    var movie : Movie!
    
    
    @IBOutlet weak var titleBgView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var plotShortLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var metaScoreLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var directorsLabel: UILabel!
    @IBOutlet weak var writersLabel: UILabel!
    
    lazy var presenter : MovieDetailsPresenter = MovieDetailsPresenter(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Title = \(self.movie.title) ")
        self.presenter.delegate = self
        self.presenter.fetchMovieDetailsfor(self.movie.imdbID!)
        self.navigationController?.navigationBar.hidden = false
    
    }
    override func viewWillAppear(animated: Bool) {
        
        // self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
       
    }

    override func viewWillLayoutSubviews() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Mark - MovieDetailsPresenterdelegate
    
    func onMovieDetailsData(movie : Movie)
    {
        
        
        self.movieTitleLabel.text = movie.title
        self.genreLabel.text = "Genre : \(movie.genre!)"
        self.durationLabel.text = " duration : \(movie.runTime!)"
        
        self.awardsLabel.text = movie.awards
        self.metaScoreLabel.text = movie.metascore
        self.countryLabel.text =    "Country  : \(movie.country!)"
        self.actorsLabel.text =     "Actors   : \(movie.actors!)"
        self.directorsLabel.text =  "Director : \(movie.director!)"
        self.writersLabel.text =    "Writer    : \(movie.writer!)"
        self.plotShortLabel.text = movie.plot
        self.ratingsLabel.text = "\(movie.imdbRating!) (\(movie.imdbVotes!) votes )"
        
        self.posterImageView.image = UIImage(named: "placeHolderImage")
        OMDBMediaAPIManager.retrieveOMDBMediaAsset(movie,
                                                   
                                                   completion:{(imageMovie: Movie, mediaImage: UIImage?) -> Void in
                                                    dispatch_async(dispatch_get_main_queue(),{
                                                        if mediaImage == nil{
                                                            self.posterImageView.image = UIImage(named: "placeHolderImage")
                                                        }
                                                        else{
                                                            
                                                            self.posterImageView.clipsToBounds = true
                                                            self.posterImageView.alpha = 0.6
                                                            UIView.animateWithDuration(0.5, delay: 0.0, options:UIViewAnimationOptions.CurveEaseOut, animations: {() -> Void in
                                                                self.posterImageView.alpha =  1.0
                                                                },completion:{(finished: Bool) -> Void in
                                                                    
                                                                    NSLog("Done!")
                                                                    self.posterImageView.alpha =  1.0
                                                                    print("Animation done")
                                                                    
                                                            } )
                                                            self.posterImageView.image = mediaImage
                                                        }
                                                        
                                                    })
        })
        

       
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    

}
