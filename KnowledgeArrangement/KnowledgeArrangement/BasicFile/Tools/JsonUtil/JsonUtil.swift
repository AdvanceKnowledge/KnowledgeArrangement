//
//  JsonUtil.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/4/8.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit
import HandyJSON
class JsonUtil: NSObject {

    //json转对象
    static func jsonToModel(_ dic:NSDictionary,modelType:HandyJSON.Type) -> BaseModel{
        if (dic.count <= 0){
            #if DEBUG
            print("jsonToModel:字典为空")
            #endif
            return BaseModel()
        }
        return modelType.deserialize(from: dic) as! BaseModel
//        (from: jsonStr) as! BaseModel
        
    }
    
    //数组转模型数组
    static func jsonArraryToModels(_ arrary:NSArray,modelType:HandyJSON.Type) -> [BaseModel]{
        if arrary.count <= 0 {
            #if DEBUG
            print("jsonArraryToModels:数组为空")
            #endif
            return []
        }
        var modelArray:[BaseModel] = []
        for dic in arrary {
            modelArray.append(dictionaryToModel(dic as! [String : Any], modelType))
        }
        return modelArray
    }
    
    /**
     *  字典转对象
     */
    static func dictionaryToModel(_ dictionStr:[String:Any],_ modelType:HandyJSON.Type) -> BaseModel {
        if dictionStr.count == 0 {
            #if DEBUG
            print("dictionaryToModel:字符串为空")
            #endif
            return BaseModel()
        }
        return modelType.deserialize(from: dictionStr) as! BaseModel
    }
    
}
