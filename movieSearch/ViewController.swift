//
//  ViewController.swift
//  movieSearch
//
//  Created by Satya on 30/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MovieSearchResultsPresenterdelegate,UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    var searchResultsArray : NSMutableArray = []
    var currentPage : Int = 0
    var totalPages : Int = 0
    var loadedCellCount : Int = 0
    lazy var presenter : MovieSearchResultsPresenter = MovieSearchResultsPresenter(delegate: self)
    let scopeStringsArray = ["", "movie", "series", "episode"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        movieTableView.registerNib(nib, forCellReuseIdentifier: "cell")
        self.presenter.delegate = self
        self.navigationController?.navigationBar.hidden = true
        self.currentPage = 1
        self.totalPages = 0
        self.loadedCellCount = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
       self.navigationController?.navigationBar.hidden = true
        
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    {
        
        print("selected index \(selectedScope)")
        if searchBar.text!.characters.count > 0 {
            let type = self.scopeStringsArray[selectedScope]
            self.currentPage = 1
            self.totalPages = 0
            self.loadedCellCount = 0
            self.searchResultsArray.removeAllObjects()
            self.movieTableView.reloadData()
            self.presenter.fetchSearchResultsWith(searchBar.text!, andType: type, offset : "\(currentPage)")
        }

    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        
        print(searchBar.text!)
        if searchBar.text!.characters.count > 0 {
            let type = self.scopeStringsArray[searchBar.selectedScopeButtonIndex]
            self.currentPage = 1
            self.totalPages = 0
            self.loadedCellCount = 0
            self.searchResultsArray.removeAllObjects()
            self.movieTableView.reloadData()
            self.presenter.fetchSearchResultsWith(searchBar.text!, andType: type, offset : "\(currentPage)")
        }
        searchBar.resignFirstResponder()
        //searchBar.text = ""
        
    }

    
    // Mark- UITableViewDataSource delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if (indexPath.row < self.searchResultsArray.count) {
            var cell : MovieTableViewCell = movieTableView.dequeueReusableCellWithIdentifier("cell") as! MovieTableViewCell
            var movie: Movie = (self.searchResultsArray.objectAtIndex(indexPath.row) as? Movie)!
            
            cell.movieTitle.text = movie.title
            cell.moviePoster.image = UIImage(named: "placeHolderImage")
            cell.movieSubTitle.text = "Type : \(movie.type!)"
            OMDBMediaAPIManager.retrieveOMDBMediaAsset(movie,completion:{(imageMovie: Movie, mediaImage: UIImage?) -> Void in
                                                        dispatch_async(dispatch_get_main_queue(),{
                                                            if mediaImage == nil{
                                                                cell.moviePoster.image = UIImage(named: "placeHolderImage")
                                                            }
                                                            else{
                                                                
                                                                cell.moviePoster.transform = CGAffineTransformMakeScale(0.3,0.3)
                                                                cell.moviePoster.clipsToBounds = true
                                                                cell.moviePoster.alpha = 0.6
                                                                UIView.animateWithDuration(0.5, delay: 0.0, options:UIViewAnimationOptions.CurveEaseOut, animations: {() -> Void in
                                                                        cell.moviePoster.transform = CGAffineTransformMakeScale(1.0,1.0);
                                                                        cell.moviePoster.alpha =  1.0
                                                                    },
                                                                    completion:{(finished: Bool) -> Void in
                                                                        NSLog("Done!")
                                                                        cell.moviePoster.alpha =  1.0
                                                                        print("Animation done")
                                                                    })
                                                                cell.moviePoster.image = mediaImage
                                                            }
                                                        })
                                                    })
            
            cell.movieReleasingYear?.text = movie.year
            
            return cell
        }
        else {
            return self.loadingCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if (self.currentPage == 0) {
            return 1;
        }
        
        if (self.currentPage < self.totalPages) {
            return self.searchResultsArray.count + 1;
        }
        return self.searchResultsArray.count;
        
    }
    
    //Mark - UITableViewdelegate
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        var movie: Movie = (self.searchResultsArray.objectAtIndex(indexPath.row) as? Movie)!
        self.presenter.loadDetailViewControllerFor(movie)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell.tag == Constant.kLoadingCellTag {
            
            self.currentPage++
            self.presenter.fetchSearchResultsWith(self.searchBar.text!, andType : "movie", offset : "\(currentPage)" )
            
        }
        
        
        
    }
    func loadingCell() -> UITableViewCell {
        
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.darkGrayColor()
        let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityIndicator.center = cell.center
        cell.addSubview(activityIndicator)
        cell.tag = Constant.kLoadingCellTag;
        
        return cell;
    }

    
    
    //Mark - MovieSearchResultsPresenterdelrceTreeegate
    
    
    func onSearchResults(result : NSArray?, totalresults : Int)
    {
       if totalresults%10 == 0
       {
            self.totalPages = totalresults / 10
       }
       else{
            self.totalPages = totalresults / 10
            self.totalPages += 1
        }
        if result?.count > 0 {
        self.searchResultsArray.addObjectsFromArray(result as! [AnyObject])
//        let arrayofIndexPaths : [NSIndexPath]
//        let loadedSearchResultCount = searchResultsArray.count
          self.movieTableView.reloadData()
        }
    }
    //
    
    

    // Navigation
    func loadDetailviewController(movie : Movie){
        self.performSegueWithIdentifier("Detail", sender: movie)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "Detail") {
            // pass data to next view
            if let viewController:MovieDetailsViewController  = segue.destinationViewController as? MovieDetailsViewController {
                viewController.movie = sender as? Movie
                
            }
        }
    }
    
    
}
