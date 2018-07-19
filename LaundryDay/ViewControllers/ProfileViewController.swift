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

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
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
/*
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell, for: IndexPath)
        return cell
    }
    
    func collectionview(_ collectionView: UICollectionView, viewforSupplementaryElementOfKind kind:String, at indexPath: IndexPath) ->UICollectionReusableView{
        let upperViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "upperProfileCollectionReusableView", for: indexPath) as! upperProfileCollectionReusableView
        upperViewCell.backgroundColor = UIColor.red
        return upperViewCell
    }
    
}
*/
