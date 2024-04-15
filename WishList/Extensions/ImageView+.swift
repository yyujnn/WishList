//
//  ImageView+.swift
//  WishList
//
//  Created by 정유진 on 2024/04/15.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                print("Failed to load image from \(url): \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
