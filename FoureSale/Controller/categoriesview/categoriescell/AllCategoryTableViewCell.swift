//
//  AllCategoryTableViewCell.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 04/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit

class AllCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var allcategoryCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension AllCategoryTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        allcategoryCollectionView.delegate = dataSourceDelegate
        allcategoryCollectionView.dataSource = dataSourceDelegate
        allcategoryCollectionView.tag = row
        allcategoryCollectionView.setContentOffset(allcategoryCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        allcategoryCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { allcategoryCollectionView.contentOffset.x = newValue }
        get { return allcategoryCollectionView.contentOffset.x }
    }
}
