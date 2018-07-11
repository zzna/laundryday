//
//  AddClothesToClosetViewController.swift
//  LaundryDay
//
//  Created by CAUAD19 on 2018. 7. 11..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class AddClothesToClosetViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var user: UserInfo!
    var items = [Clothes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchUser()
        fetchMyItems()
        collectionView.isUserInteractionEnabled = true

    }
    func fetchUser() {
        Api.User.observeCurrentUser(completion: {user in
            self.user = user
            self.collectionView.reloadData()
        })
    }

    func fetchMyItems() {
        guard let currentUser = Api.User.CURRENT_USER else {
            return
        }
        Api.MyItems.REF_MYITEMS.child(currentUser.uid).observe(.childAdded, with: {snapshot in
            Api.Clothes.observeClothes(withId: snapshot.key, completion: {clothes in
                self.items.append(clothes)
                self.collectionView.reloadData()
            })
        })
    }
    @IBAction func cancelButton_TUI(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

extension AddClothesToClosetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddClothesToClosetCollectionViewCell", for: indexPath) as! AddClothesToClosetCollectionViewCell
        let item = items[indexPath.row]
        cell.item = item
        
        return cell
    }
}
extension AddClothesToClosetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //사진 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 - 2, height: 150)
    }
}
