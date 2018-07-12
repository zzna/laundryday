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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchUser()
        fetchMyItems()
        collectionView.isUserInteractionEnabled = true

        //closet list
        updateChildView()

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
    //TODO: touch enable
    @IBAction func openClosetList(_ sender: Any) {
        closetListShowing = !closetListShowing
        //뒤에 컬렉션뷰 터치 안되게 하는건데 다른 더 좋은 방법 없을까?..
        //다른 뷰 하나 추가해서 block? insertView 생각해봅세
        
        if closetListShowing {
            collectionView.isUserInteractionEnabled = false
        } else {
            collectionView.isUserInteractionEnabled = true
        }
        updateChildView()
        
        
    }
    func updateChildView() {
        if closetListShowing {
            closetListViewController.view.frame = CGRect(x: -260, y: collectionView.frame.origin.y, width: 250, height: 600)
            UIView.animate(withDuration: 0.3, animations: { self.closetListViewController.view.frame = CGRect(x: 0, y: self.collectionView.frame.origin.y, width: 250, height: 600)})
        } else {
            closetListViewController.view.frame = CGRect(x: 0, y: self.collectionView.frame.origin.y, width: 250, height: 600)
            UIView.animate(withDuration: 0.3, animations: { self.closetListViewController.view.frame = CGRect(x: -260, y: self.collectionView.frame.origin.y, width: 250, height: 600)})
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            let cell = sender as? ClosetCollectionViewCell
            let detailVC = segue.destination as! DetailViewController
            detailVC.itemId = cell?.item?.id
           
        }
    }

    //테스트중
    lazy var closetListViewController: ClosetListViewController = {
        let storyboard = UIStoryboard(name: "Closet", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "ClosetListViewController") as! ClosetListViewController

        self.addViewControllerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()


    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)

        view.addSubview(childViewController.view)
        
        //TODO: closet list view resize
        //사이즈 조정 필요
        childViewController.view.frame = CGRect(x: -260, y: collectionView.frame.origin.y, width: 250, height: 600)
        //childViewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        childViewController.didMove(toParentViewController: self)
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
