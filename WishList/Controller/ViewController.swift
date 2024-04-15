//
//  ViewController.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let networkingManager = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
    }
    
    // 위시 리스트 담기 Btn
    @IBAction func tappedSaveProductButton(_ sender: UIButton) {
    }
    
    // 다른 상품 보기 Btn
    @IBAction func tappedSkipButton(_ sender: UIButton) {
        fetchProduct()
    }
    
    // 위시 리스트 보기 Btn
    @IBAction func tappedPresentWishList(_ sender: UIButton) {
    }
    
    func fetchProduct() {
        networkingManager.fetchRemoteProduct { result in
            switch result {
            case .success(let product):
                // UI 요소들과 데이터를 연결하여 표시
                DispatchQueue.main.async {
                    self.imageView.loadImage(url: product.thumbnail)
                    self.titleLabel.text = product.title
                    self.descriptionLabel.text = product.description
                    self.priceLabel.text = "\(product.price)"
                }
            case .failure(let error):
                print("Error fetching product: \(error)")
            }
        }
    }
    
    
}