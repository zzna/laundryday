//
//  DetailViewController.swift
//  LaundryDay
//
//  Created by CAUADC on 2018. 6. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!

    
    var itemId: String?
    var item: Clothes? {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        loadItem()
        
    }
    func updateView() {
        self.productNameLabel.text = item?.productName
        if let photoUrlString = item!.productImgUrl {
            let photoUrl = URL(string: photoUrlString)
            self.productImageView.sd_setImage(with: photoUrl)
        }
    }

    func loadItem(){
        Api.Clothes.observeClothes(withId: itemId!, completion: {clothes in
            self.item = clothes
            
        })
    }


}
