//
//  LaundryShopTableViewCell.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 7. 31..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class LaundryShopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shopNameLabel : UILabel!
    @IBOutlet weak var shopAddressLabel : UILabel!
    @IBOutlet weak var shopContactNumber : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
