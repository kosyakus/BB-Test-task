//
//  UsersTableViewCell.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbnail.clipsToBounds = true
        self.thumbnail.layer.cornerRadius = 20.0
        self.thumbnail.layer.borderWidth = 3.0
        self.thumbnail.layer.borderColor = UIColor.white.cgColor
        
        self.nameLabel.layer.cornerRadius = 10.0
        self.nameLabel.clipsToBounds = true
        self.emailLabel.layer.cornerRadius = 10.0
        self.emailLabel.clipsToBounds = true
        
        self.viewCell.layer.cornerRadius = 10.0
        self.viewCell.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
