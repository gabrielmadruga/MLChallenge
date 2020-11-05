//
//  ProductSplitViewController.swift
//  MLChallenge
//
//  Created by Gabriel Madruga on 11/5/20.
//

import UIKit

class ProductSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    // Issues in iOS 14 https://medium.com/swlh/ios-14-uisplitviewcontroller-5-issues-that-you-may-run-into-65b09601b3fb
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
    
}

