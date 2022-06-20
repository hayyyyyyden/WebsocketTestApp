//
//  MessageCell.swift
//  WebsocketTestApp
//
//  Created by hayden on 2022/6/20.
//

import UIKit

class MessageCell: UICollectionViewCell {
    static let reuseIdentifier : String = "MessageCell"
    @IBOutlet weak var textLabel: UILabel!
    
    func configure(with message: String) {
        textLabel.text = message
    }
}
