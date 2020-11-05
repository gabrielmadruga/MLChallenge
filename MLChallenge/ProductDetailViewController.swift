//
//  DetailViewController.swift
//  MLChallenge
//
//  Created by Gabriel Madruga on 11/5/20.
//

import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var item: ProductSearchItem! {
        didSet {
            refresh()
        }
    }
    
    private func refresh() { 
        loadViewIfNeeded()
        titleLabel.text = item.title
        priceLabel.text = "\(item.currency) \(item.price)"
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        imageView.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onViewWebVersionTouchUpInside(_ sender: Any) {
        if let link = URL(string: item.permalink) {
          UIApplication.shared.open(link)
        }
    }
    
}

extension ProductDetailViewController: ProductMasterTableViewControllerDelegate {
    func itemSelected(_ item: ProductSearchItem) {
        self.item = item
    }
}
