//
//  Clothes.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 5. 17..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import Foundation

class Clothes  {
    var productImgUrl: String?
    var productName: String?
    var uid: String?
    var id: String?
    var isLiked: Bool?
    var imageString: String?
    //var isSelected: Bool?
    
}
extension Clothes {
    static func transformClothes(dict: [String:Any], key:String) -> Clothes {
        let clothes = Clothes()
        clothes.productImgUrl = dict["productImgUrl"] as? String
        clothes.productName = dict["productName"] as? String
        clothes.uid = dict["uid"] as? String
        clothes.id = key
        clothes.imageString = dict["imageString"] as? String
        clothes.isLiked = dict["isLiked"] as? Bool
        //clothes.isSelected = false
        return clothes
    }
}

