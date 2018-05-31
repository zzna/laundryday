//
//  ClothesApi.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 5. 22..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import Foundation
import FirebaseDatabase
class ClothesApi {
    let REF_ITEMS = Database.database().reference().child("items")
    
    func observeClothes(withId id: String, completion: @escaping (Clothes)-> Void) {
        REF_ITEMS.child(id).observeSingleEvent(of: .value, with: {snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let clothes = Clothes.transformClothes(dict: dict, key: snapshot.key)
                completion(clothes)
            }
        })
        
    }
    //like/unlike 방법2
//    func observeLiked(postId: String,  onSuccess: @escaping (Clothes)->Void, onError:@escaping (_ errorMessage: String?) -> Void) {
//        let itemRef = Api.Clothes.REF_ITEMS.child(postId)
//        itemRef.runTransactionBlock({(currentData: MutableData) -> TransactionResult in
//            if var item = currentData.value as? [String: AnyObject] {
//                var isLiked = item["isLiked"] as? Bool
//                if isLiked == true {
//                    isLiked = false
//                } else {
//                    isLiked = true
//                }
//                item["isLiked"] = isLiked as AnyObject?
//                currentData.value = item
//                return TransactionResult.success(withValue: currentData)
//            }
//            return TransactionResult.success(withValue: currentData)
//        }) { (error, committed, snapshot) in
//            if let error = error {
//                onError(error.localizedDescription)
//            }
//            if let dict = snapshot?.value as? [String: Any] {
//                let item = Clothes.transformClothes(dict: dict, key: snapshot!.key)
//                onSuccess(item)
//            }
//
//        }
//    }
    func likeAction(withItem id: String) {
        REF_ITEMS.child(id).child("isLiked").setValue(true)
    }
    func unLikeAction(withItem id: String) {
        REF_ITEMS.child(id).child("isLiked").setValue(NSNull())
    }
    
    func isLiked(itemId: String, completed: @escaping (Bool)-> Void) {
        REF_ITEMS.child(itemId).child("isLiked").observeSingleEvent(of: .value, with: {snapshot in
            if let _ = snapshot.value as? NSNull {
                completed(false)
            }else {
                completed(true)
            }
        })
    }
    

}
