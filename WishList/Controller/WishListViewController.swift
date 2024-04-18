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
        setRefreshControl()
    }
    
    // MARK: - 테이블뷰 구성
    func configureTableView() {
        self.navigationController?.navigationBar.tintColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "WishListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "WishListTableViewCell")
    }
    
    // MARK: - 코어데이터 불러오기
    func loadWishList() {
        wishList = CoreDataManager.fetchCoreData()
        tableView.reloadData()
    }
    
    // MARK: - Pull to Refresh
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFire), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refreshFire() {
        loadWishList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell",  for: indexPath) as? WishListTableViewCell else { return UITableViewCell() }
        
        cell.bind(wishList[indexPath.row])
        
        // MARK: - cell 버튼 삭제
        cell.deleteHandler = { [weak self] in
            guard let self = self else { return }
            // 사용자에게 확인 메시지를 표시하는 알림 창 생성
            let alert = UIAlertController(title: "WISH LIST", message: "상품을 위시리스트에서 삭제하시겠습니까?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "예", style: .default) { _ in
                let selectedProduct = self.wishList[indexPath.row]
                let productId = selectedProduct.id
                
                CoreDataManager.deleteProduct(withId: productId) { success in
                    if success {
                        print("상품 삭제 성공")
                        self.loadWishList()
                    } else {
                        print("상품 삭제 실패")
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "아니오", style: .default)
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            self.present(alert, animated: true)
        }
        
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
