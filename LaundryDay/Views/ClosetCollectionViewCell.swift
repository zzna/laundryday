//
//  ClosetCollectionViewCell.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 5. 17..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import ProgressHUD

class ClosetCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    
    
    var item: Clothes? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        productName.text = item?.productName
        if let photoUrlString = item?.productImgUrl {
            let photoUrl = URL(string: photoUrlString)
            productImageView.sd_setImage(with: photoUrl)
        }
        Api.Clothes.observeClothes(withId: item!.id!, completion: {item in
            self.updateLike(item: item)
        })
        
        
    }
    
    func updateLike(item: Clothes) {
        let imageName = (item.isLiked)! ? "likeSelected" : "like"
        likeImageView.image = UIImage(named: imageName)
        print("update LIKE")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(self.likeImageView_TUI))
        likeImageView.addGestureRecognizer(tapGestureForLikeImageView)
        likeImageView.isUserInteractionEnabled = true
        
    }

    @objc func likeImageView_TUI() {
        Api.Clothes.observeLiked(postId: item!.id!, onSuccess: {item in
            self.updateLike(item: item)
        }, onError: {errorMessage in
            ProgressHUD.showError(errorMessage)
        })
        
    }
   
    
    
}
