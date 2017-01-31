//
//  MovieInfo.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 29.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit
import EVReflection

protocol MovieInfo {
    var title: String { get }
    var type: String { get }
    var year: String { get }
    var posterURL: String { get }
    var imdbID: String { get }
    var runtime: String { get }
    var genre: String { get }
    var actors: String { get }
    var plot: String { get }
    var error: String { get }
}
