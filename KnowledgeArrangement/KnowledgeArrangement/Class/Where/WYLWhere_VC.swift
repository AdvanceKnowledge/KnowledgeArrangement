//
//  WYLWhere_VC.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/8/20.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit
class WYLWhere_VC: ParentsVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        switch_Where()
        for_Where()
    }
  // TODO:首先在switch中,我们可以使用Where来限定某些特定的case
    func switch_Where() {
        let names = ["王小二","张三","李四","王五"]
        names.forEach {
            switch $0{
            case let x where x.hasPrefix("王"):
                print("\(x)是笔者本家")
                break
            default:
                print("你好,\($0)")
                break
            } 
        }
    }
    
    func for_Where() {
        let num = [[12,23,48,59],[49,55,12,23,45]]
        let n = num.flatMap {$0}
        for score in n where score > 30{
            print("及格啦\(score)")
        }
    }
}
