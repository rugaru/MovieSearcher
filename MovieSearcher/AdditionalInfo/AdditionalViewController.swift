//
//  AdditionalViewController.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

class AdditionalViewController: UIViewController {
    var movieToDisplay: MovieInfo = MovieDataImpl(movieDataInit: MovieData())
    let additionaInfoPresenter = AdditionalPresenter()
    var viewFromXib = AdditionalView()

    override func viewDidLoad() {
        super.viewDidLoad()
        additionaInfoPresenter.attachView(view: self)
        viewFromXib = UINib(nibName: "AdditionalView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AdditionalView
        self.view.addSubview(viewFromXib)
        additionaInfoPresenter.attachView(view: self)
        additionaInfoPresenter.getMovie(imdbID: movieToDisplay.imdbID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension AdditionalViewController: AdditionalInfoView {
    
    func setMovie(movie: MovieInfo) {
        movieToDisplay = movie
        self.viewFromXib.setMovie(movieInfo: movieToDisplay);
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (alert :UIAlertAction!) -> Void in
             self.popToRootViewController()
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

