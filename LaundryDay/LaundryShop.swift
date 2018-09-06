//
//  File.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 8. 1..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import Foundation
/*
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
<title>Naver Open API - local ::'갈비집'</title>
<link>http://search.naver.com</link>
<description>Naver Search Result</description>
<lastBuildDate>Tue, 04 Oct 2016 13:10:58 +0900</lastBuildDate>
<total>407</total>
<start>1</start>
<display>10</display>
 
 
<item>
<title>조선옥</title>
<link />
<category>한식&gt;육류,고기요리</category>
<description>연탄불 한우갈비 전문점.</description>
<telephone>02-2266-0333</telephone>
<address>서울특별시 중구 을지로3가 229-1 </address>
<roadAddress>서울특별시 중구 을지로15길 6-5 </roadAddress>
<mapx>311277</mapx>
<mapy>552097</mapy>
</item>
...
</channel>
</rss>
*/
class LaundryShop {
    //init(){}
    
    var title: String?
    var roadAddress: String?
    var telephone : String?
    var description : String?
    var mapx: Float?
    var mapy: Float?
    
    //이거 왜만든지 모르겠음.
    /*
    init (title: String, roadAddress: String, telephone: String, mapx: Float, mapy: Float, description: String){
        self.title = title
        self.roadAddress = roadAddress
        self.telephone = telephone
        self.mapx = mapx
        self.mapy = mapy
        self.description = description
     } */
}
