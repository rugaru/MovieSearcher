//
//  MovieData.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 29.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit
import EVReflection

class MovieData: EVObject {
    var Title: String = ""
    var Year: String = ""
    var Rated: String = ""
    var Released: String = ""
    var Runtime: String = ""
    var Genre: String = ""
    var Director: String = ""
    var Writer: String = ""
    var Actors: String = ""
    var Plot: String = ""
    var Language: String = ""
    var Country: String = ""
    var Awards: String = ""
    var Poster: String = ""
    var Metascore: String = ""
    var imdbRating: String = ""
    var imdbVotes: String = ""
    var imdbID: String = ""
    var `Type`: String = ""
    var Response: String = ""
    var Error: String = ""
    
    public func toMovieInfo() -> MovieInfo {
        return MovieDataImpl(movieDataInit: self)
    }
    
}
