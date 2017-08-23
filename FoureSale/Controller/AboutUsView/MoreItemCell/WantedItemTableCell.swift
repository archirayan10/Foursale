//
//  WantedItemTableCell.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 31/07/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class WantedItemTableCell: UITableViewCell {

    @IBOutlet var categoryNameLabel: UILabel?
    @IBOutlet var serachButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    @IBOutlet var expiryDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
