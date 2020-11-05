//
//  UITableViewExtensions.swift
//  MLChallenge
//
//  Created by Gabriel Madruga on 11/15/20.
//

import UIKit

extension UITableView {

    func setupBackgroundView() {
        let messageLabel = UILabel(frame: self.bounds)
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = messageLabel
    }
    
    func setMessage(_ message: String) {
        if let messageLabel = self.backgroundView as? UILabel {
            messageLabel.text = message
            messageLabel.sizeToFit()
            self.separatorStyle = .none
        }
    }

    func removeMessage() {
        setMessage("")
        self.separatorStyle = .singleLine
    
    }
}
