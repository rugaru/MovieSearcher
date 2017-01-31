//
//  MainInfoTableViewController.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 29.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit

let cellIdentifier = "cell1"

class MainInfoTableViewController: UITableViewController {
    let mainInfoPresenter = MainInfoPresenter()
    var movieToDisplay = [MovieInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MainInfoCell", bundle: nil), forCellReuseIdentifier: "Cell")
        mainInfoPresenter.attachView(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MainInfoCell
        let movieViewData = movieToDisplay[indexPath.row]
        self.mainInfoPresenter.setPoster(imageView: cell.posterImageView, url: movieViewData.posterURL)
        cell.nameMovieLabel.text = movieViewData.title
        cell.genreMovieLabel.text = movieViewData.type
        cell.yearMovieLabel.text = movieViewData.year
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieData = movieToDisplay[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "AdditionalView") as! AdditionalViewController
        myVC.movieToDisplay = movieData
        navigationController?.pushViewController(myVC, animated: true)
    }
    
}

extension MainInfoTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mainInfoPresenter.getMovie(title: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}

extension MainInfoTableViewController: MainInfoView {
    
    func setMovies(movies: [MovieInfo]) {
        movieToDisplay = movies
        self.tableView.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
