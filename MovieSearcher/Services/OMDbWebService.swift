//
//  OMDbWebService.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 29.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import Foundation
import Alamofire

class OMDbWebService: NSObject, MovieInfoWebService {
    public func getMoviesInfo(title:String, callback:@escaping(_ answer: MovieSearchArray, _ success: Bool) -> ()) {
        let json = String(format:  "http://www.omdbapi.com/?s=%@&y=&plot=short&r=json", title)
        Alamofire.request(json).responseString { response in
            var movieInfo = MovieSearchArray()
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
            if response.result.isSuccess {
                movieInfo =  MovieSearchArray(json: response.result.value!)
            }
            callback(movieInfo, response.result.isSuccess)
        }
    }

    public func getMovieAdditionalInfo(imdbID:String, callback:@escaping(_ answer: MovieInfo, _ success: Bool) -> ()) {
        let json = String(format:  "http://www.omdbapi.com/?i=%@&plot=short&r=json", imdbID)
        Alamofire.request(json).responseString { response in
            var movieInfo = MovieDataImpl.createEmpty()
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
            if response.result.isSuccess {
                movieInfo =  MovieData(json: response.result.value!).toMovieInfo()
            }
            callback(movieInfo, response.result.isSuccess)
        }
    }
}
