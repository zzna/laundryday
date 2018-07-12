//
//  AddClothesToClosetViewController.swift
//  LaundryDay
//
//  Created by CAUAD19 on 2018. 7. 11..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import ProgressHUD
class AddClothesToClosetViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var user: UserInfo!
    var items = [Clothes]()
    var closetItemsID = [String]()
    var closetName: String?
    
    @IBOutlet weak var createClosetBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        fetchUser()
        fetchMyItems()
        collectionView.isUserInteractionEnabled = true
        
        createClosetBtn.isUserInteractionEnabled = false


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
    
    @IBAction func createClosetBtn_TUI(_ sender: Any) {
        ProgressHUD.show("Waiting")
        HelperService.sendClosetDataToDatabase(closetName: closetName!, items: closetItemsID, onSuccess: {
            self.dismiss(animated: true, completion: nil)
            self.closetItemsID.removeAll()
            ProgressHUD.showSuccess()
            })
        
    }
    
    func checkArray() {
        if closetItemsID.count <= 0 {
            createClosetBtn.isUserInteractionEnabled = false
            createClosetBtn.titleLabel?.textColor = .lightGray
        } else {
            createClosetBtn.isUserInteractionEnabled = true
            createClosetBtn.titleLabel?.textColor = .blue
        }
    }
    
   
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemCount = items[indexPath.row]
        let itemKey = itemCount.id!
        
        
        closetItemsID.append(itemKey)
        checkArray()
        print(closetItemsID)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let itemDeCount = items[indexPath.row]
        let cancelItemKey = itemDeCount.id!
        if let itemIndex = closetItemsID.index(of: cancelItemKey) {
            closetItemsID.remove(at: itemIndex)
        }
        checkArray()
        print(closetItemsID)

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
