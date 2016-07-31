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
    @IBOutlet weak var segmentationCotrol: UISegmentedControl!
    @IBOutlet weak var movieTableView: UITableView!
    var searchResultsArray : NSMutableArray = []
    lazy var presenter : MovieSearchResultsPresenter = MovieSearchResultsPresenter(delegate: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        movieTableView.registerNib(nib, forCellReuseIdentifier: "cell")
        self.presenter.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        
        print(searchBar.text!)
        self.searchResultsArray.removeAllObjects()
        self.movieTableView.reloadData()
        self.presenter.fetchSearchResultsWith(searchBar.text!, andType: "movie")
        searchBar.resignFirstResponder()
        searchBar.text = ""
        
    }

    
    // Mark- UITableViewDataSource delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell : MovieTableViewCell = movieTableView.dequeueReusableCellWithIdentifier("cell") as! MovieTableViewCell
        
        var movie: Movie = (self.searchResultsArray.objectAtIndex(indexPath.row) as? Movie)!
        
        cell.movieTitle.text = movie.title
        cell.moviePoster.image = UIImage(named: "placeHolderImage")
        OMDBMediaAPIManager.retrieveOMDBMediaAsset(movie,
                                                   
                                                   completion:{(imageMovie: Movie, mediaImage: UIImage?) -> Void in
                                                    dispatch_async(dispatch_get_main_queue(),{
                                                        if mediaImage == nil{
                                                            cell.moviePoster.image = UIImage(named: "placeHolderImage")
                                                        }
                                                        else{
                                                            cell.moviePoster.image = mediaImage
                                                        }
                                                        
                                                    })
                                                })
        
        cell.movieSubTitle.text = movie.actors
        cell.movieReleasingYear?.text = movie.year
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.searchResultsArray.count;
    }
    
    
    //Mark - UITableViewdelegate
    
    // 4
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
    }
    
    // 5
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    //Mark - MovieSearchResultsPresenterdelegate
    
    
    func onSearchResults(result : NSArray?)
    {
        
        self.searchResultsArray.addObjectsFromArray(result as! [AnyObject])
        self.movieTableView.reloadData()
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
