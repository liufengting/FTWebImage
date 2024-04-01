//
//  DemoCell.swift
//  Demo
//
//  Created by LiuFengting on 2024/4/1.
//

import UIKit
import FTWebImage

class DemoCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWith(imageURL: String) {
        self.avatarImageView.loadImage(fromURL: URL(string: imageURL), completion: nil)
    }

}
