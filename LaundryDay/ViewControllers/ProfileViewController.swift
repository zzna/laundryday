//
//  ProfileViewController.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 4. 14..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import ProgressHUD

class ProfileViewController: UIViewController {
    var currentUser: UserInfo?
    
    //드래그해서 아울렛 불러오면 오류가 나길래(프로필뷰를 찾을 수 없다) 그냥 연결 없이 쓰기만 했는데 해결됨... 언제 터질지 모름. 엑스코드를 믿지 말자.
    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: UserInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchUser()
    
    }
    func fetchUser() { //this method want curring(?) current user information
        Api.User.observeCurrentUser{(user) in
            self.user=user
            self.collectionView.reloadData()
        }
    }
        // Do any additional setup after loading the view.
    
    
    
    @IBAction func logOutButton_TUI(_ sender: Any) {
       
        AuthService.logout(onSuccess: {let storyboard = UIStoryboard(name: "Start", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)}, onError: {errorMessage in
                ProgressHUD.showError(errorMessage)
        })
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}



// 정아: 프로필 뷰 계정 정보


extension ProfileViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderProfileCollectionReusableView", for: indexPath) as! HeaderProfileCollectionReusableView
        headerViewCell.user = self.user
        return headerViewCell
    }

}
