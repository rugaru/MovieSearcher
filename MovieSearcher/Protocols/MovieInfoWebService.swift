//
//  MovieInfoWebService.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 29.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import Foundation

protocol MovieInfoWebService {
    func getMoviesInfo(title:String, callback:@escaping(_ answer: MovieSearchArray, _ success: Bool) -> ())
    func getMovieAdditionalInfo(imdbID:String, callback:@escaping(_ answer: MovieInfo, _ success: Bool) -> ())
}
