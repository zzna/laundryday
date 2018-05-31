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
        //like 방법2
//        Api.Clothes.observeClothes(withId: item!.id!, completion: {item in
//            self.updateLike(item: item)
//        })
        Api.Clothes.isLiked(itemId: item!.id!, completed: {value in
            if value {
                self.configureUnLike()
            } else {
                self.configureLike()
            }
        })
        
    }
    //like 방법2
//    func updateLike(item: Clothes) {
//        let imageName = (item.isLiked)! ? "likeSelected" : "like"
//        likeImageView.image = UIImage(named: imageName)
//        print("update LIKE")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //like 방법2
//        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(self.likeImageView_TUI))
//        likeImageView.addGestureRecognizer(tapGestureForLikeImageView)
//        likeImageView.isUserInteractionEnabled = true
        
    }
    //like 방법2
//    @objc func likeImageView_TUI() {
//        Api.Clothes.observeLiked(postId: item!.id!, onSuccess: {item in
//            self.updateLike(item: item)
//        }, onError: {errorMessage in
//            ProgressHUD.showError(errorMessage)
//        })
//
//    }
    func configureLike() {
        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(self.likeAction))
        likeImageView.addGestureRecognizer(tapGestureForLikeImageView)
        likeImageView.isUserInteractionEnabled = true
        likeImageView.image = UIImage(named: "like")
    }
    func configureUnLike() {
        let tapGestureForUnLikeImageView = UITapGestureRecognizer(target: self, action: #selector(self.unLikeAction))
        likeImageView.addGestureRecognizer(tapGestureForUnLikeImageView)
        likeImageView.isUserInteractionEnabled = true
        likeImageView.image = UIImage(named: "likeSelected")

    }
    
    @objc func likeAction() {
        Api.Clothes.likeAction(withItem: item!.id!)
        configureUnLike()
    }
    @objc func unLikeAction(){
        Api.Clothes.unLikeAction(withItem: item!.id!)
        configureLike()
    }
    
}
