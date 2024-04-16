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
    
}
