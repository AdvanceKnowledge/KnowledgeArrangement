//
//  NetTools.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/4/8.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit
import Alamofire
class NetTools: NSObject {
    static func request(_ url:String,method:HTTPMethod ,paramas:[String: Any]? = nil, block:@escaping (_ isSuccess:Bool, _ posts:NSDictionary?,_ error:Error?) -> Void) -> Void{
        
        
        Alamofire.AF.request(url, method: method,
                             parameters: paramas,
                             encoding: JSONEncoding.default,
                             headers: nil).responseJSON { (res) in
            if (res.response?.statusCode == 200){
                let dic:NSDictionary = try! JSONSerialization.jsonObject(with: res.data!,
                                                                         options: JSONSerialization.ReadingOptions())
                as! NSDictionary
                block(true,dic,nil)
            }else{
                block(false,nil,res.error)
            }
        }
    }
}
