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
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    var currentProduct: RemoteProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchRemoteProduct()
        setRefreshControl()
    }
    
    func setUI() {
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
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
        
        let alert = UIAlertController(title: "WISH LIST", message: "상품을 위시리스트에 추가하시겠습니까?", preferredStyle: .alert)
        let addButton = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            CoreDataManager.saveWishProduct(product: product) { success in
                if success {
                    print("상품이 위시 리스트에 추가되었습니다.")
                    
                    guard let nextVC = self?.storyboard?.instantiateViewController(withIdentifier: "WishListViewController") else { return }
                    
                    self?.modalPresentationStyle = .fullScreen
                    self?.present(nextVC, animated: true)
                    
                } else {
                    print("상품을 위시 리스트에 추가하는 데 실패했습니다.")
                }
            }
        }
        let cancelButton = UIAlertAction(title: "아니오", style: .default)
        
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        self.present(alert, animated: true)
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
        NetworkingManager.fetchRemoteProduct { result in
            switch result {
            case .success(let product):
                // 현재 상품 업데이트
                self.currentProduct = product
                
                // UI 요소들과 데이터를 연결하여 표시
                DispatchQueue.main.async {
                    self.imageView.loadImage(url: product.thumbnail)
                    self.brandLabel.text = product.brand
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
