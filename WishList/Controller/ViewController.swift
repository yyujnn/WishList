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
    let coreDataManager = CoreDataManager()
    var currentProduct: RemoteProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRemoteProduct()
        
    }
    
    // 위시 리스트 담기 Btn
    @IBAction func tappedSaveProductButton(_ sender: UIButton) {
        coreDataManager.saveWishProduct()
        CoreDataManager.fetchCoreData()
    }
    
    // 다른 상품 보기 Btn
    @IBAction func tappedSkipButton(_ sender: UIButton) {
        fetchRemoteProduct()
    }
    
    // 위시 리스트 보기 Btn
    @IBAction func tappedPresentWishList(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController") else { return }
        
        self.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    func fetchRemoteProduct() {
        networkingManager.fetchRemoteProduct { result in
            switch result {
            case .success(let product):
                // UI 요소들과 데이터를 연결하여 표시
                DispatchQueue.main.async {
                    self.imageView.loadImage(url: product.thumbnail)
                    self.titleLabel.text = product.title
                    self.descriptionLabel.text = product.description
                    self.priceLabel.text = "\(product.price)$"
                }
            case .failure(let error):
                print("Error fetching product: \(error)")
            }
        }
    }
    
    
}
