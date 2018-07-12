//
//  AddClothesToClosetCollectionViewCell.swift
//  LaundryDay
//
//  Created by CAUAD19 on 2018. 7. 11..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class AddClothesToClosetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    var checkmarkView: SSCheckMark!
    var item: Clothes? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let photoUrlString = item?.productImgUrl {
            let photoUrl = URL(string: photoUrlString)
            productImageView.sd_setImage(with: photoUrl)
            checkmarkView = SSCheckMark(frame: CGRect(x: frame.width-40, y: 10, width: 35, height: 35))
            checkmarkView.backgroundColor = UIColor(white: 1.0, alpha: 0)
            productImageView.addSubview(checkmarkView)
        }
    }


    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkmarkView.checked = true
            }else {
                checkmarkView.checked = false
            }
        }
    }
    


}
