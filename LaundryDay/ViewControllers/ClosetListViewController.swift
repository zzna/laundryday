//
//  TestViewController.swift
//  LaundryDay
//
//  Created by CAUADC on 2018. 6. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import ProgressHUD

class ClosetListViewController: UIViewController {
    
   
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //var closetName: String?
    var myClosets = [Closet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        
        fetchMyClosets()

    }
    
    func fetchMyClosets() {
        guard let currentUser = Api.User.CURRENT_USER else {
            return
        }
        Api.MyClosets.REF_MYCLOSETS.child(currentUser.uid).observe(.childAdded, with: {snapshot in
            Api.Closets.observeCloset(withId: snapshot.key, completion: { closet in
                self.myClosets.append(closet)
                self.tableView.reloadData()
            })
        })
    }
    
    @IBAction func addListButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "옷장 추가하기", message: "옷장 이름을 정해주세요", preferredStyle: .alert)
        
        actionSheet.addTextField(configurationHandler: {textField in
            textField.text = ""
        })
        
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .default, handler: {(_) in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "다음", style: .default, handler: {(_) in
            //ProgressHUD.show("Waiting")
            guard let closetName = actionSheet.textFields?[0].text else {
                return
            }
            if let vc = UIStoryboard(name: "Closet", bundle: nil).instantiateViewController(withIdentifier: "AddClothesToClosetViewController") as? AddClothesToClosetViewController {
                self.present(vc, animated: true, completion: nil)
                vc.closetName = closetName
            }


        }))
        self.present(actionSheet,animated: true,completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClosetViewController" {
            let closetVC = segue.destination as! ClosetViewController
            let id = sender as! String
            closetVC.closetId = id

            closetVC.closetListShowing = false

        }
    }
    
    
    
}





extension ClosetListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myClosets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClosetListTableViewCell", for: indexPath) as! ClosetListTableViewCell
        let closet = myClosets[indexPath.row]
        cell.closet = closet
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = myClosets[indexPath.row]
        let selectedCellClosetId = selectedCell.id
        self.performSegue(withIdentifier: "ClosetViewController", sender: selectedCellClosetId)
    }
    

}

extension ClosetListViewController: UITableViewDelegate {
    
}

