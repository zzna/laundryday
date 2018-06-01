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
    
    var closetName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView

    }
    
    @IBAction func addListButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "옷장 추가하기", message: "옷장 이름을 정해주세요", preferredStyle: .alert)
        
        actionSheet.addTextField(configurationHandler: {textField in
            textField.text = ""
        })
        
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .default, handler: {(_) in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "추가", style: .default, handler: {(_) in
            ProgressHUD.show("Waiting")
            self.closetName = actionSheet.textFields?[0].text
            if let closetNameText = self.closetName {
                print(closetNameText)
            } else {
                ProgressHUD.showError("텍스트를 입력해주세요")
            }
            
        }))
        self.present(actionSheet,animated: true,completion: nil)
    }
    
    
    
 
}



extension ClosetListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClosetListTableViewCell", for: indexPath) as! ClosetListTableViewCell
        return cell
    }

}

extension ClosetListViewController: UITableViewDelegate {
    
}

