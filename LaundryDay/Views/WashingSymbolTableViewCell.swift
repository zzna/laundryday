//
//  WashingSymbolTableViewCell.swift
//  LaundryDay
//
//  Created by mjcho on 2018. 10. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class WashingSymbolTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolImage: UIImageView!
    @IBOutlet weak var symbolDescription: UITextView!
    var key: String?
    var value: String?
    var list: [String:String]?{
        didSet {
            changeToString()
            updateView()
        }
    }
    func changeToString() {
        list?.forEach {
            ref in
            key = ref.key
            value = ref.value
        }
    }
    
    func updateView() {
        symbolImage.image = UIImage(named: key!)
        symbolDescription.text = value!
        symbolDescription.isUserInteractionEnabled = false
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
