//
//  HeaderProfileCollectionReusableViewdCollectionReusableView.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 7. 22..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
class HeaderProfileCollectionReusableView: UICollectionReusableView {
    //사용자 정보 불러오기
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPostsCountLabel: UILabel!
    @IBOutlet weak var myCommentsCountLabel: UILabel!
    @IBOutlet weak var myPublicClosetCountLabel: UILabel!
    @IBOutlet weak var myFrendsCountLabel: UILabel!
    
    var user: User? {
        didSet{
            updateView()
        }
    }
    func updateView(){
        self.nameLabel.text=user!.username
        if let photoUrlString = user.profileImageUrl{
            let photoUrl = URL(string: photoUrlString)
            self.profileImage.sd_setImage(with: photoUrl)
            
        }
    }
}
