//
//  First_VC.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/3/6.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit
class First_VC: BaseVC {
    let list_tab = UITableView()
    
    let vcs:NSArray = ["RunLoopMode_VC",
                       "ResponseArea_VC",
                       "ColorToImage",
                       "WYLOperator_VC",
                       "WYLMirror_VC",
                       "WYLWhere_VC",
                       "WYLThreadLockVC",
                       "WYLMVVMVC",
                       "WYLKeyBoardVC",
                       "VideoPlaybackViewController",
                       "WYLChartVC",
                       "WYLDealImage",
                       "WYLDataPersistenceVC",
//                       "WYLWeatherVC"
    ]
    let vc_title = ["RunLoop",
                    "button响应区域",
                    "颜色转图片",
                    "自定义操作符",
                    "镜像-Mirror","Where关键字",
                    "iOS 线程锁",
                    "MVVM",
                    "自定义数字键盘",
                    "视频播放",
                    "统计图",
                    "图片添加圆角/圆形",
                    "数据持久化",
//                    "苹果天气"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Example().example()
        
        Const.navtitle(name: "首页", controller: self)
        self.view.addSubview(list_tab)
        list_tab.tableFooterView = UIView()
        list_tab.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        list_tab.delegate = self
        list_tab.dataSource = self
        list_tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        sorted()
        
        shareLoading.startProgressAnimating()
    }
}

extension First_VC:UITableViewDelegate,UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return vcs.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = vc_title[indexPath.row]
        return cell!
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let class_VC =  NSClassFromString("KnowledgeArrangement.\(vcs.object(at: indexPath.row))") as! UIViewController.Type
        
        let vc = class_VC.init()
        vc.navigationItem.title = vc_title[indexPath.row]
         self.pushNext_VC(nextVC: vc)
    }
    
    
    //数组排序
    func sorted() -> Void {
        let arrary = ["B","C","D","BA","1"]
        
        let arrary2 = arrary.sorted { (value1, value2) -> Bool in
            /*
             //从大到小
             return value1 > value2
             */
            //从小到大
            return value1 < value2
        }
        
        print(arrary2)
    }
}
