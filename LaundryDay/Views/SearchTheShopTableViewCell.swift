//
//  SearchTheShopTableViewCell.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 7. 31..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class SearchTheShopTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet var shopNameLabel : UILabel!
    @IBOutlet var shopLoadAddressLabel : UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
