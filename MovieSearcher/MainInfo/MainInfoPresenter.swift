//
//  MainInfoPresenter.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 29.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

protocol MainInfoView: NSObjectProtocol {
    func setMovies(movies: [MovieInfo])
    func showAlert(message: String)
}

class MainInfoPresenter: NSObject {
    weak fileprivate var mainInfoView: MainInfoView?
    fileprivate let service: MovieInfoWebService
    
    override init() {
        service = OMDbWebService()
    }
    
    func attachView(view: MainInfoView) {
        mainInfoView = view
    }
    
    func getMovie(title: String) {
        let movieTitle = title.replacingOccurrences(of: " ", with: "+")
        service.getMoviesInfo(title:movieTitle) {array, success in
            self.setMovies(movies: array, success: success)
        }
    }
    
    func setPoster(imageView:UIImageView, url:String) {
        WebImageHelper.loadTo(imageView: imageView, url: url)
    }
    
    func setMovies(movies: MovieSearchArray, success:Bool) {
        if success {
            if movies.Error != "" {
                self.mainInfoView?.showAlert(message: movies.Error)
            }
            self.mainInfoView?.setMovies(movies: SearchArrayHelper.toMovieInfoArray(array: movies.Search))
        } else {
            self.mainInfoView?.showAlert(message: "ERROR")
        }
    }
    
    
}
