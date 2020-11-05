//
//  ProductTableViewCell.swift
//  MLChallenge
//
//  Created by Gabriel Madruga on 11/9/20.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var item: ProductSearchItem! {
        didSet {
            refresh()
        }
    }
    
    private func refresh() {
        titleLabel.text = item.title
        priceLabel.text = "\(item.currency) \(item.price)"
        thumbnailImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        thumbnailImageView.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "placeholder.png"))
    }

}
