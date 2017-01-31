//
//  MovieSearchInfo.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

class MovieSearchInfo: NSObject {
    var Title: String = ""
    var Year: String = ""
    var imdbID: String = ""
    var `Type`: String = ""
    var Poster: String = ""

    
    public func toMovieInfo() -> MovieInfo {
        return MovieSearchInfoImpl(movieDataInit: self)
    }
}
