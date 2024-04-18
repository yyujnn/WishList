//
//  ViewController.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let networkingManager = NetworkingManager()
    var currentProduct: RemoteProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRemoteProduct()
        setRefreshControl()
    }
    
    // MARK: - Pull to Refresh
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFire), for: .valueChanged)
        self.scrollView.refreshControl = refreshControl
    }
    
    @objc func refreshFire() {
        fetchRemoteProduct()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: -  위시 리스트 담기 Btn
    @IBAction func tappedSaveProductButton(_ sender: UIButton) {
        guard let product = currentProduct else { return }
        print("위시리스트 담는 상품: \(product)")
        CoreDataManager.saveWishProduct(product: product) { success in
            if success {
                print("상품이 위시 리스트에 추가되었습니다.")
            } else {
                print("상품을 위시 리스트에 추가하는 데 실패했습니다.")
            }
        }
    }
    
    // MARK: - 다른 상품 보기 Btn
    @IBAction func tappedSkipButton(_ sender: UIButton) {
        fetchRemoteProduct()
    }
    
    // MARK: - 위시 리스트 보기 Btn
    @IBAction func tappedPresentWishList(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController") else { return }
        
        self.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    // MARK: - 데이터 가져와 컴포넌트와 연결
    func fetchRemoteProduct() {
        networkingManager.fetchRemoteProduct { result in
            switch result {
            case .success(let product):
                // 현재 상품 업데이트
                self.currentProduct = product
                
                // UI 요소들과 데이터를 연결하여 표시
                DispatchQueue.main.async {
                    self.imageView.loadImage(url: product.thumbnail)
                    self.titleLabel.text = product.title
                    self.descriptionLabel.text = product.description
                    self.priceLabel.text = product.price.formatAsCurrency()
                }
            case .failure(let error):
                print("Error fetching product: \(error)")
            }
        }
    }
}
