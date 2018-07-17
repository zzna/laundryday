//
//  ClosetViewController.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 4. 14..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import SDWebImage

class ClosetViewController: UIViewController {

    @IBOutlet weak var leadingViewConstraint: NSLayoutConstraint!
    var closetListShowing = false
    
    
    @IBOutlet weak var closetListView: UIView!
    @IBOutlet weak var closetListButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var user: UserInfo!
    var items = [Clothes]()
    var closetId: String = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchUser()
        checkClosetId(closetID: closetId)
        
        collectionView.isUserInteractionEnabled = true

        //closet list
        //updateChildView()
        
        print("viewDidLoad")

    }
    
    func checkClosetId(closetID: String) {
        if closetID == "All" {
            fetchMyItems()
        } else {
            fetchItemsInCloset()
        }
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
    
    
    func fetchItemsInCloset() {

        Api.Closets.REF_CLOSETS.child(closetId).child("items").observe(.childAdded, with: { snapshot in
            Api.Clothes.observeClothes(withId: snapshot.key, completion: {clothes in
                self.items.removeAll()
                self.items.append(clothes)
                self.collectionView.reloadData()
            })
        })
    }
    
    
    @IBAction func openClosetList(_ sender: Any) {
        closetListShowing = !closetListShowing

        let vc = storyboard?.instantiateViewController(withIdentifier: "ClosetListViewController") as? ClosetListViewController
        vc?.delegate = self
        displayChildViewController(vc: vc!)
        view.addSubview((vc?.view)!)
        vc?.didMove(toParentViewController: self)
        vc?.view.frame = CGRect(x: 0, y: self.collectionView.frame.origin.y, width: 250, height: 600)
    
    }
    
    func displayChildViewController(vc: UIViewController) {
        addChildViewController(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            let cell = sender as? ClosetCollectionViewCell
            let detailVC = segue.destination as! DetailViewController
            detailVC.itemId = cell?.item?.id
           
        }
    }
    
    
    
    
    
    

 

}

//MARK: - collection view extension

extension ClosetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothes", for: indexPath) as! ClosetCollectionViewCell
        let item = items[indexPath.row]
        cell.item = item
        
        return cell
    }
}

extension ClosetViewController: UICollectionViewDelegateFlowLayout {
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

extension ClosetViewController: ClosetListViewControllerDelegate {
    func selectedValue(Value: String) {
        self.closetId = Value
        checkClosetId(closetID: closetId)
    }
    

}
