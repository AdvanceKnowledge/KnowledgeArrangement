//
//  VideoModel.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/7/29.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import Foundation
import RealmSwift
import HandyJSON

//class VideoListModel: Object, HandyJSON {
//    ///主键
//    @objc dynamic var id = 0
//    
//    @objc dynamic var videoList: [VideoModel]? {
//        willSet {
//            
//            if newValue != nil {
//                newValue!.forEach { model in
//                    listModel.append(model)
//                }
//            }
//            
//        }
//    }
//    
//    let listModel = List<VideoModel>()
//    
//    override class func ignoredProperties() -> [String] {
//        ["videoList"]
//    }
//    
//    //    [WYLImageModel]()
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//    
//    override required init() {
//        super.init()
//    }
//    
//}

class VideoModel:BaseModel {
    var id = ""
//    NSUUID().uuidString
    var cover = ""
    var descriptionDe = ""
    var length = 0
    var length2 = 0
    var m3u8Hd_url = ""
    var m3u8_url = ""
    var mp4Hd_url = ""
    var mp4_url = ""
    var playCount = 0.0
    var playersize = 0.0
    var ptime = ""
    var replyBoard = ""
    var replyid = 0.0
    var title = ""
    var topicDesc = ""
    var topicImg = ""
    var topicName = ""
    var topicSid = ""
    var vid = ""
    var videoTopic = ""
    var videosource = ""
    
}
