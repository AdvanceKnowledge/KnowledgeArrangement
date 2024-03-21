//
//  WYLDataPersistenceVC.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2023/1/12.
//  Copyright © 2023 ProgrammerHome. All rights reserved.
//

import UIKit

class WYLDataPersistenceVC: ParentsVC {
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImages()
    }

    
    func getImages() {
        NetTools.request("http://www.bing.com/HPImageArchive.aspx?format=js&idx=1&n=10&mkt=en-US", method: .get, paramas: nil) { isSuccess, posts, error in
            let model = WYLDataPersistenceModel.deserialize(from: posts, designatedPath: nil) ?? WYLDataPersistenceModel()
            RealmManager.share.updateObject(model)
            self.showData()
        }
    }
    
    func showData() {
        var detailModel = RealmManager.share.findObjects(withType: WYLDataPersistenceModel.self).first
        print(detailModel?.subImage[0].title)
        try! realmGlobal.write({
            detailModel?.subImage[0].title = "修改后"
        })
        
        print(detailModel?.subImage[0].title)
        
    }
}
