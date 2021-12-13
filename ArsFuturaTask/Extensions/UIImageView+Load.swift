//
//  UIImageView+Load.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 18.11.2021.
//

import UIKit

extension UIImageView {
    func loadImage(at url: String) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
