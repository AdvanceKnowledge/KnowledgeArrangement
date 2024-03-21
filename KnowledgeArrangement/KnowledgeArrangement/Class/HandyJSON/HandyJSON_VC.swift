//
//  HandyJSON_VC.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/4/8.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit

class HandyJSON_VC: ParentsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        NetTools.request("http://47.]52.68.101:8089/guzhi/appnewsandnotice/notice_list", method: .post, paramas: nil) { (isSuccess,posts, error) in
            if (!isSuccess){
                //请求失败
                return
            }
            let models = JsonUtil.jsonArraryToModels(posts!["data"] as! NSArray, modelType: MyModel.self)
            print(models.count)
        }
    }
}
