//
//  AdditionalView.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

class AdditionalView: UIView {

    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var titleMovie: UILabel!

    @IBOutlet var movieInfoText: UITextView!
    
    override func layoutSubviews() {
        for subView in self.subviews {
            subView.frame = subView.bounds
        }
    }
    
    func setMovie(movieInfo: MovieInfo) {
        WebImageHelper.loadTo(imageView: self.posterImageView, url: movieInfo.posterURL)
        self.titleMovie.text = movieInfo.title
        let info = String(format: "Type - %@ \nyear - %@  \ngenre - %@ \nactors - %@ \nruntime - %@ \nplot - %@",
                          movieInfo.type, movieInfo.year,movieInfo.genre, movieInfo.actors, movieInfo.runtime, movieInfo.plot)
        
        movieInfoText.text = info
    }
    
}
