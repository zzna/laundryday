//
//  DetailEditingViewController.swift
//  LaundryDay
//
//  Created by CAUAD19 on 2018. 7. 25..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import ProgressHUD

class DetailEditingViewController: UIViewController {
    var uid: String?
    var clothesId: String?
    var imageString: String?
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
        actionSheet.addAction(UIAlertAction(title: "예", style: .cancel, handler: {(alertAction) in
            print("touched yes")
            Api.Clothes.removeClothesInStorage(imageString: self.imageString!, onSuccess: {
                print("removeStorage")
                Api.Clothes.removeClothesOnDatabase(clothesId: self.clothesId!, uid: self.uid!, onSuccess: {
                    print("remove on Database")
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    }, onError: {error in
                        ProgressHUD.showError(error)
                })
                }, onError: {err in
                    ProgressHUD.showError(err)
            })
            
        }))
        self.present(actionSheet,animated: true,completion: nil)
    }

    

}
