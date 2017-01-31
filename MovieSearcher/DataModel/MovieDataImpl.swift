//
//  MovieDataImpl.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

class MovieDataImpl: MovieInfo {
    private var movieData: MovieData
    
    public static func createEmpty() -> MovieInfo {
        return MovieDataImpl(movieDataInit: MovieData())
    }
    
    init(movieDataInit: MovieData) {
        movieData = movieDataInit
    }
    
    var title: String { get {
        return movieData.Title
        }
    }
    
    var type: String { get {
        return movieData.Type
        }
    }
    
    var year: String { get {
        return movieData.Year
        }
    }
    
    var posterURL: String { get {
        return movieData.Poster
        }
    }
    
    var imdbID: String { get {
        return movieData.imdbID
        }
    }
    
    var runtime: String { get {
        return movieData.Runtime
        }
    }
    
    var genre: String { get {
        return movieData.Genre
        }
    }
    
    var actors: String { get {
        return movieData.Actors
        }
    }
    var plot: String { get {
        return movieData.Plot
        }
    }
    
    var error: String { get {
        return movieData.Error
        }
    }
}
