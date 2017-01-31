//
//  MovieSearchArray.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit
import EVReflection

class MovieSearchArray: EVObject {
    var Search: [MovieSearchInfo] = []
    var totalResults:String = ""
    var Response:String = ""
    var Error: String = ""
}
