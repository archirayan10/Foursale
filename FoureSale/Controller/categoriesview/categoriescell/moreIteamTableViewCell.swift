//
//  moreIteamTableViewCell.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 26/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class moreIteamTableViewCell: UITableViewCell {
    @IBOutlet var itemImage: UIImageView!

    @IBOutlet var itemNameLabel: UILabel!
    
    @IBOutlet var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
