//
//  ClosetListTableViewCell.swift
//  LaundryDay
//
//  Created by CAUADC on 2018. 6. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class ClosetListTableViewCell: UITableViewCell {

    @IBOutlet weak var closetNameLabel: UILabel!
    
    
    //var closetListVC: ClosetListViewController?
    
    var closet: Closet? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        closetNameLabel.text = closet?.closetName
        
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
