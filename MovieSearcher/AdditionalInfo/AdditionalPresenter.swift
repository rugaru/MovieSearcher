//
//  AditionalPresenter.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

protocol AdditionalInfoView: NSObjectProtocol {
    func setMovie(movie: MovieInfo)
    func showAlert(message: String)
}

class AdditionalPresenter: NSObject {
    weak fileprivate var additionalInfoView: AdditionalInfoView?
    fileprivate let service: OMDbWebService
    
    override init() {
        service = OMDbWebService()
    }
    
    func attachView(view: AdditionalInfoView) {
        additionalInfoView = view
    }
    
    func getMovie(imdbID: String) {
        service.getMovieAdditionalInfo(imdbID:imdbID) {answer, success in
            self.setMovie(movie: answer, success: success)
        }
    }
    
    func setMovie(movie: MovieInfo, success:Bool) {
        if success {
            if movie.error != "" {
                self.additionalInfoView?.showAlert(message: movie.error)
            }
            self.additionalInfoView?.setMovie(movie: movie)
        } else {
            self.additionalInfoView?.showAlert(message: "ERROR")
        }
    }

}
