//
//  Example.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2024/3/12.
//  Copyright © 2024 ProgrammerHome. All rights reserved.
//

import Foundation
class Example {
    func example() {
        
        // 使用工厂类创建产品并打印描述
        if let product = Factory.createProduct(type: "A") {
            print(product.description())
        }
        
        if let product = Factory.createProduct(type: "B") {
            print(product.description())
        }
        
        
        
        // 使用工厂创建汽车并打印信息
//        let sedanFactory = SedanCarFactory()
//        let sedan = sedanFactory.createCar(name: "Model S", color: "Blue")
//        print("Created car: \(sedan.name), Color: \(sedan.color), Price: \(sedan.price)")
//
//        let suvFactory = SUVFactory()
//        let suv = suvFactory.createCar(name: "Model X", color: "Black")
//        print("Created car: \(suv.name), Color: \(suv.color), Price: \(suv.price)")
        
        
        let sedan = SubCarFactory.createCar(type: .SECDN, name: "特斯拉", color: "蓝色")
        let suvCar = SubCarFactory.createCar(type: .SUV, name: "哈弗", color: "白色")
        let electric = SubCarFactory.createCar(type: .Electric, name: "雅迪电动车", color: "黄色")
        print("Created car: \(sedan.name), Color: \(sedan.color), Price: \(sedan.price)")
        print("Created car: \(suvCar.name), Color: \(suvCar.color), Price: \(suvCar.price)")
        print(electric.getName())
        //------------------------------------------------------------------------
        
        //------------------------------------------------------------------------
        // 使用抽象工厂创建并打印产品
        let factory1 = ConcreteFactory1()
        print(factory1.createProductA().description())
        print(factory1.createProductB().description())

        let factory2 = ConcreteFactory2()
        print(factory2.createProductA().description())
        print(factory2.createProductB().description())
        //------------------------------------------------------------------------
        
        //------------------------------------------------------------------------
        // 建造者模式使用
        let builder = ConcreteBuilder()
        let director = Director(builder: builder)
        director.constructProduct(with: "Component A", partB: "Component B")
        //------------------------------------------------------------------------
        
        
    }
}
