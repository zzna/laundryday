//
//  ShopTableViewCell.swift
//  LaundryDay
//
//  Created by mjcho on 2018. 9. 6..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roadAddress: UILabel!
    @IBOutlet weak var title: UILabel!
    var laundryShop: LaundryShop? {
        didSet {
            updateView()
        }
    }
    func updateView() {
        roadAddress.text = laundryShop?.roadAddress
        title.text = laundryShop?.title
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
