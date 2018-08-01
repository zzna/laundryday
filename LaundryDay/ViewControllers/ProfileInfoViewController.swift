//
//  ProfileInfoViewController.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 7. 28..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     
    //@IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var profileInfoView: UIView!
     
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var myPostsCount : UILabel!
    @IBOutlet weak var myCommentsCount : UILabel!
    @IBOutlet weak var myPublicClosetCount : UILabel!
    @IBOutlet weak var myFriendsCount: UILabel!
    
    var user: UserInfo?{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        //if let self.nameLabel.text=user?.userName{
        //    print(self.nameLabel.text)
        //}
        self.nameLabel.text=user?.userName
        
        
    }
}
     
    
     
    
  /*
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
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

    }*/

