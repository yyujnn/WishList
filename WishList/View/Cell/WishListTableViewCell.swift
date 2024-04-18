//
//  WishListTableViewCell.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ product: Product) {
        self.idLabel.text = "[\(product.id)]"
        self.titleLabel.text = product.title
        self.priceLabel.text = product.price.formatAsCurrency()
        self.brandLabel.text = product.brand
        
        NetworkingManager.fetchProductImage(id: Int(product.id)) { image in
            DispatchQueue.main.async {
                self.cellImageView.image = image
            }
        }
    }
}
