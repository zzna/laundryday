//
//  WashingSymbolViewController.swift
//  LaundryDay
//
//  Created by mjcho on 2018. 10. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class WashingSymbolViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var themeLabel: UILabel!
    
    var theme: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = headerView
        themeLabel.text = theme

    }
    @IBAction func cancelBtn(_ sender: Any) {
        ClosetListViewController.removeViewController(childVC: self)

    }
    
    var delegate: WashingSymbolViewControllerDelegate?

}

protocol WashingSymbolViewControllerDelegate {
    func selectedValue(value: String)
}

extension WashingSymbolViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WashingSymbolTableViewCell", for: indexPath) as! WashingSymbolTableViewCell
        return cell
    }
    
    
    
}
