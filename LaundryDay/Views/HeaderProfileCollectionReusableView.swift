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
    
    var user: UserInfo? {
        didSet{
            updateView()
        }
    }
    func updateView(){
        //옵셔널체이닝 검색해서 적용해봄. fatal error
        //그런데 모르겠어서 그냥 !만 ?로 바꿨는데 해결됨...
        
        //if let self.nameLabel.text=user?.userName{
        //    print(self.nameLabel.text)
        //}
        self.nameLabel.text=user?.userName
        
        //이것도 user!했더니 nil이라 언래핑 오류래서 그냥 ?만 바꿨는데 해결됐다..
        if let photoUrlString = user?.profileImageUrl{
            let photoUrl = URL(string: photoUrlString)
            self.profileImage.sd_setImage(with: photoUrl)
            
        }
    }
}
