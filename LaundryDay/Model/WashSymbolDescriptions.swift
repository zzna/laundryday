//
//  WashSymbolDescriptions.swift
//  LaundryDay
//
//  Created by mjcho on 2018. 10. 2..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import Foundation

struct Symbols {
    var drySymbol: [String:String] = ["dry_hangwithsun":"햇빛, 옷걸이에 걸어서 건조",
                                      "dry_hangwithshadow":"그늘, 옷걸이에 걸어서 건조",
                                      "dry_laydownwithsun":"햇빛, 바닥에 뉘어서 건조",
                                      "dry_laydownwithshadow":"그늘, 바닥에 뉘어서 건조",
                                      "dry_machine":"세탁 후 건조 시, 기계 건조 가능",
                                      "dry_nomachine":"세탁 후 건조 시, 기계 건조 불가",
                                      "dry_squeeze":"손으로 약하게 짬",
                                      "dry_notsqueeze":"손으로 짜면 안됨"]
    
    var washableSymbol = ["washable_machine95":"물 온도 95도로 세탁, 세탁기 및 손세탁 가능, 세제 종류 제한 없음, 삶을 수 있음",
                          "washable_machine60":"물 온도 60도로 세탁, 세탁기 및 손세탁 가능, 세제 종류 제한 없음",
                          "washable_machine40":"물 온도 40도로 세탁, 세탁기 및 손세탁 가능, 세제 종류 제한 없음",
                          "washable_machine40A":"물 온도 40도로 세탁, 세탁기로 약하게 세탁, 약하게 손세탁 가능, 세제 종류 제한 없음",
                          "washable_machine30":"물 온도 30도로 세탁, 세탁기로 약하게 세탁, 약하게 손세탁 가능, 중성세제 사용",
                          "washable_onlyhand":"물 온도 30도로 세탁, 세탁기 사용 불가, 약하게 손세탁 가능, 중성세제 사용",
                          "washable_nowater":"물세탁 안됨"]
        
    
    var ironingSymbol = ["ironing_possible180210":"180~210도로 다림질",
                         "ironing_withclothes180":"원단 위에 천을 덮고 180~210도로 다림질",
                         "ironing_possible140":"140~160도로 다림질",
                         "ironing_withclothes140":"원단 위에 천을 덮고 140~160도로 다림질",
                         "ironing_possible80":"80~120도로 다림질",
                         "ironing_withclothes80":"원단 위에 천을 덮고 80~120도로 다림질",
                         "ironing_notpossible":"다림질 할 수 없음"]
    
    var dryCleaningSymbol = ["drycleaning_possibledry":"드라이클리닝 가능, 용제는 클로로에틸렌 또는 석유계 사용",
                             "drycleaning_possibleoil":"드라이클리닝 가능, 용제는 석유계 사용",
                             "drycleaning_notforself":"드라이클리닝 할 수 있으나 셀프 서비스는 할 수 없음",
                             "drycleaning_notpossible":"드라이클리닝 불가"]
    
    var bleachingSymbol = ["bleaching_possibleC":"염소계 표백제로 표백",
                           "bleaching_notpossibleC":"염소계 표백제로 표백할 수 없음",
                           "bleaching_possibleO":"산소계 표백제로 표백",
                           "bleaching_notpossibleO":"산소계 표백제로 표백할 수 없음",
                           "bleaching_possibleCO":"산소,염소계 표백제로 표백",
                           "bleaching_notpossibleCO":"산소, 염소계 표백제로 표백할 수 없음"]
}

