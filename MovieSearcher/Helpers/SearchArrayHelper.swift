//
//  SearchArrayHelper.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

class SearchArrayHelper: NSObject {
    static func toMovieInfoArray(array:[MovieSearchInfo]) -> [MovieInfo] {
        return array.map({ (movieData:MovieSearchInfo) -> MovieInfo in
            return movieData.toMovieInfo()
        });
    }

}
