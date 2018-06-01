//
//  Closet.swift
//  LaundryDay
//
//  Created by CAUADC on 2018. 6. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import Foundation

class Closet {
    var closetName: String?
    var uid: String?
    var id: String?
    //var list: String? array?
}

extension Closet {
    static func transformCloset(dict: [String: Any], key: String) -> Closet {
        let closet = Closet()
        closet.closetName = dict["closetName"] as? String
        closet.id = dict["id"] as? String
        closet.uid = dict["uid"] as? String
        
        return closet
    }
}
