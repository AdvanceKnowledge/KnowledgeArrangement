//
//  WYLWYLDataPersistenceModel.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2023/1/12.
//  Copyright © 2023 ProgrammerHome. All rights reserved.
//

import UIKit
import HandyJSON
import RealmSwift
class WYLDataPersistenceModel: Object, HandyJSON {
    
    ///主键
    @objc dynamic var id = 0
    
    let subImage = List<WYLImageModel>()
    
    @objc dynamic var images: [WYLImageModel]? {
        willSet {
            if newValue != nil {
                newValue!.forEach { model in
                    subImage.append(model)
                }
            }
            
        }
    }
    
    
    override class func ignoredProperties() -> [String] {
            ["images"]
        }
    
//    [WYLImageModel]()
    override static func primaryKey() -> String? {
        return "id"
    }
    override required init() {
        super.init()
    }
}

class WYLImageModel: Object, HandyJSON {
    
    @objc dynamic var id = 0
    @objc dynamic var  bot = 1
    @objc dynamic var  copyright = "印度活根桥 (© dhritipurna/Shutterstock)"
    @objc dynamic var  copyrightlink = "https://www.bing.com/search?q=%E6%B4%BB%E6%A0%B9%E6%A1%A5&form=hpcapt&mkt=zh-cn"
    @objc dynamic var  drk = 1
    @objc dynamic var  enddate = "20190627"
    @objc dynamic var  fullstartdate = "201906261600"
    @objc dynamic var  hsh = "6efd1731e25b4b1001f007bba6e770b5"
    @objc dynamic var  quiz = "/search?q=Bing+homepage+quiz&filters=WQOskey:%22HPQuiz_20190626_RootBridge%22&FORM=HPQUIZ"
    @objc dynamic var  startdate = "20190626"
    @objc dynamic var  title = ""
    @objc dynamic var  top = 1
    @objc dynamic var  url = "/th?id=OHR.RootBridge_ZH-CN5173953292_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"
    @objc dynamic var  urlbase = "/th?id=OHR.RootBridge_ZH-CN5173953292"
    @objc dynamic var  wp = true
    
    
    override required init() { }
}



