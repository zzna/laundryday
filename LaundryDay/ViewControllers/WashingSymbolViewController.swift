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
    var list : [String:String]!
    var eachSymbol = [[String:String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableHeaderView = headerView
        themeLabel.text = theme
        list.forEach { ref  in
            let key = ref.key
            let value = ref.value
            eachSymbol.append([key:value])
            
        }

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
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WashingSymbolTableViewCell", for: indexPath) as! WashingSymbolTableViewCell
        
        cell.list = self.eachSymbol[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = eachSymbol[indexPath.row]
        let selectedCellClosetId = selectedCell.keys.first
        
        if (delegate != nil) {
            delegate?.selectedValue(value: selectedCellClosetId!)
        }
        
        ClosetListViewController.removeViewController(childVC: self)
        
    }
    
    
    
    
}
