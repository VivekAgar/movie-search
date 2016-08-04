//
//  MovieDetailsViewController.swift
//  movieSearch
//
//  Created by Satya on 31/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import UIKit
import MBProgressHUD

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
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    lazy var presenter : MovieDetailsPresenter = MovieDetailsPresenter(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Title = \(self.movie.title) ")
        self.presenter.delegate = self
        self.presenter.fetchMovieDetailsfor(self.movie.imdbID!)
        self.navigationController?.navigationBar.hidden = false
        self.scrollView.hidden = true
        self.messageView.hidden = false
         self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
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
        self.scrollView.hidden = false
        self.messageView.hidden = true
        self.movieTitleLabel.text = "\(movie.title!) \n \(movie.year!)"
        self.genreLabel.text = "Genre : \(movie.genre!)"
        self.durationLabel.text = " duration : \(movie.runTime!)"
        self.awardsLabel.text = movie.awards
        self.metaScoreLabel.text = " \(movie.metascore!) Metascore"
        
        self.countryLabel.text =    "\(movie.country!)"
        self.actorsLabel.text =     "\(movie.actors!)"
        self.directorsLabel.text =  "\(movie.director!)"
        self.writersLabel.text =    "\(movie.writer!)"
        self.plotShortLabel.text = movie.plot
        self.ratingsLabel.text = "\(movie.imdbRating!) \n (\(movie.imdbVotes!) votes )"
        
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
                                                            self.posterImageView.image = mediaImage
                                                            //get the colors of image
                                                            self.setTitleBackGround(mediaImage!)
                                                            UIView.animateWithDuration(0.5, delay: 0.0, options:UIViewAnimationOptions.CurveEaseOut, animations: {() -> Void in
                                                                self.posterImageView.alpha =  1.0
                                                                },completion:{(finished: Bool) -> Void in
                                                                    
                                                                    NSLog("Done!")
                                                                    self.posterImageView.alpha =  1.0
                                                                    print("Animation done")
                                                                    
                                                            } )
                                                            
                                                        }
                                                        
                                                    })
        })
        
    }
    
    
    func setTitleBackGround(mediaImage : UIImage){
        
        let scaledWidth : CGFloat = mediaImage.size.width * 0.3
        let scaledHeight : CGFloat = mediaImage.size.height * 0.3
            mediaImage.getColors(CGSizeMake(scaledWidth, scaledHeight),
                 completionHandler: { (colors: UIImageColors) -> Void in
                    
                    self.titleBgView.backgroundColor = colors.primaryColor
                    self.navigationController?.navigationBar.barStyle = .BlackTranslucent
                    self.navigationController?.navigationBar.backgroundColor = colors.primaryColor
                    self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
                    //self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                    self.navigationController?.navigationBar.translucent = true
                    self.navigationController?.navigationBar.setBackgroundImage(UIImage() , forBarMetrics:.Default)
                    
            })
    
    }
    
    
    
    func onNoResults(){
        
        self.scrollView.hidden = true
        self.messageView.hidden = false
        self.messageLabel.text = " No search Results found "
    
    }
   
    func onNoNetworkavailable(){
         self.scrollView.hidden = true
        self.messageView.hidden = false
        self.messageLabel.text = "You don't seem to have an active network connection!"
    }

    func showLoading(message : String)
    {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = message
    }
    
    func hideLoadingAnimation()
    {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }

    
    

}
