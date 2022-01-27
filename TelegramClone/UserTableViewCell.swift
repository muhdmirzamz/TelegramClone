//
//  UserTableViewCell.swift
//  TelegramClone
//
//  Created by Muhd Mirza on 28/1/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet var usernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
