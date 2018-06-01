//
//  MyClosets.swift
//  LaundryDay
//
//  Created by CAUADC on 2018. 6. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MyClosetsApi {
    let REF_MYCLOSETS = Database.database().reference().child("myClosets")
}
