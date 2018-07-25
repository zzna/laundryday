//
//  DetailEditingViewController.swift
//  LaundryDay
//
//  Created by CAUAD19 on 2018. 7. 25..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

class DetailEditingViewController: UIViewController {
    
    
    @IBOutlet weak var editItemImageView: UIImageView!
    @IBOutlet weak var deleteItemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapToDeleteImageView()

        // Do any additional setup after loading the view.
    }
    
    func addTapToDeleteImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.deleteAction))
        deleteItemImageView.addGestureRecognizer(tapGesture)
        deleteItemImageView.isUserInteractionEnabled = true
    }
    @objc func deleteAction() {
        let actionSheet = UIAlertController(title: "삭제된 옷은 복구할 수 없습니다", message: "삭제하시겠습니까?", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "예", style: .cancel, handler: {(_) in
            
        }))
        self.present(actionSheet,animated: true,completion: nil)
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
