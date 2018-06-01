//
//  ClosetsApi.swift
//  LaundryDay
//
//  Created by CAUADC on 2018. 6. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ClosetsApi {
    let REF_CLOSETS = Database.database().reference().child("closets")
    
    
    func observeCloset(withId id: String, completion: @escaping (Closet) -> Void) {
        REF_CLOSETS.child(id).observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let closet = Closet.transformCloset(dict: dict, key: snapshot.key)
                completion(closet)
            }
        })
    }
}
