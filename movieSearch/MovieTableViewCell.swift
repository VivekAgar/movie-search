//
//  MovieTableViewCell.swift
//  movieSearch
//
//  Created by Satya on 26/07/16.
//  Copyright © 2016 slonkit. All rights reserved.
//

import UIKit


class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
   
    @IBOutlet weak var movieSubTitle: UILabel!
    @IBOutlet var movieReleasingYear: UILabel!
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMoviePosterImage(image:UIImage)->Void
    {
        self.moviePoster.image = image
    }
    
    func setMovieTitleText(title:String)->Void{
    
        self.movieTitle.text = title
    }
    func setMovieSubTitleText(subTitle:String)->Void{
        
        self.movieSubTitle.text = subTitle
    }
    func setMovieReleaseYear(year:String)->Void{
        
        self.movieReleasingYear.text = year
    }
    
    
    
}
