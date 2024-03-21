//
//  WYLMirror_VC.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/7/12.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit

struct Person {
    let name :String
    let age :String
}

class WYLMirror_VC: ParentsVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.text = """
        通过Mirror初始化得到的结果中包含的元素描述都被集合在children属性下,如果你有新可以到Swift标准库中查找它的定义,它实际上是一个Child的集合,而Childc则是一对键值的多元组:
        public typealias Child = (label:String?,value:Any)
        public typealias Childrn = AnyCollection<Mirror.Type.Child>
        """
        self.view.addSubview(lab)
        lab.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
                   make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        
        
        
        let person = Person(name: "张三", age: "23")
        let mirror = Mirror(reflecting: person)
        for child in mirror.children {
            print("属性名\(child.label ??  "key"),值\(child.value)")
            
        }
        dump(person)
        let name = valueFrom(person, key: "name")
        if ((name  ) != nil){
            print(name!)
        }
    }
    
    
    
    
    
    func valueFrom(_ object:Any,key:String) -> Any? {
        let mirror = Mirror(reflecting: object)
        for child in mirror.children{
            let (targetKey,targetValue) = (child.label,child.value)
            if (targetKey == key){
                return targetValue
            }
            
            
        }
        
        return nil
    }

}
