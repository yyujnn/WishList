//
//  WishListViewController.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var tempWishList: [Product] = [product1, product2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "WishListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "WishListTableViewCell")
    }
}
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempWishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell",  for: indexPath) as? WishListTableViewCell else { return UITableViewCell() }
        
        cell.bind(tempWishList[indexPath.row])
        return cell
        
    }
    
}
