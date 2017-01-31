//
//  MovieInfoImpl.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

class MovieSearchInfoImpl: MovieInfo {
    private var movieData: MovieSearchInfo
    
    init(movieDataInit: MovieSearchInfo) {
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
        return ""
        }
    }
    
    var genre: String { get {
        return ""
        }
    }
    
    var actors: String { get {
        return ""
        }
    }

    var plot: String { get {
        return ""
        }
    }
    
    var error: String { get {
        return ""
        }
    }
}
