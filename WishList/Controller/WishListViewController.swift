//
//  WishListViewController.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var wishList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        loadWishList()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "WishListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "WishListTableViewCell")
    }
    
    func loadWishList() {
        wishList = CoreDataManager.fetchCoreData()
        tableView.reloadData()
    }
    
}

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell",  for: indexPath) as? WishListTableViewCell else { return UITableViewCell() }
        
        cell.bind(wishList[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    // MARK: - cell 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 코어 데이터에서 데이터에서 셀 삭제
            let selectedProduct = wishList[indexPath.row]
            let productId = selectedProduct.id
            
            // delete 사용
            CoreDataManager.deleteProduct(withId: productId) { success in
                if success {
                    print("상품 삭제 성공")
                    self.loadWishList()
                } else {
                    print("상품 삭제 실패")
                }
            }
        }
    }
}
