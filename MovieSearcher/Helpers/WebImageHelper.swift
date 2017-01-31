//
//  WebImageHelper.swift
//  MovieSearcher
//
//  Created by Алина Усманова on 30.01.17.
//  Copyright © 2017 Алина Усманова. All rights reserved.
//

import UIKit
import SDWebImage

class WebImageHelper: NSObject {
    static func loadTo(imageView:UIImageView, url:String) {
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "emptyImage"))
    }

}
