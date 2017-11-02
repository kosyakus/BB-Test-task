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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //self.thumbnail.layer.cornerRadius = self.thumbnail.frame.size.width / 2;
        self.thumbnail.clipsToBounds = true
        self.thumbnail.layer.cornerRadius = 20.0
        self.thumbnail.layer.borderWidth = 3.0
        self.thumbnail.layer.borderColor = UIColor.brown.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
