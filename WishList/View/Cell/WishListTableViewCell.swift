//
//  WishListTableViewCell.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ product: TempProduct) {
        idLabel.text = "[\(product.id)]"
        titleLabel.text = product.title
        priceLabel.text = "\(product.price)$"
    }
    
}
