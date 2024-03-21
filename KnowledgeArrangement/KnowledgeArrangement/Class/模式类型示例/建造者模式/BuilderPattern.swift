//
//  BuilderPattern.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2024/3/12.
//  Copyright © 2024 ProgrammerHome. All rights reserved.
//

import Foundation
// 首先定义产品的抽象类或协议
protocol ProductProtocol {
    var partA: String { get set }
    var partB: String { get set }
    func showProduct()
}

// 定义具体产品类
class ConcreteProduct: ProductProtocol {
    var partA: String
    var partB: String
    
    init(partA: String, partB: String) {
        self.partA = partA
        self.partB = partB
    }
    
    func showProduct() {
        print("Product built with Part A: \(partA) and Part B: \(partB)")
    }
}

// 定义抽象建造者协议
protocol BuilderProtocol {
    associatedtype BuiltType: ProductProtocol
    
    func buildPartA(_ value: String)
    func buildPartB(_ value: String)
    func buildProduct() -> BuiltType
}

// 创建具体建造者类
class ConcreteBuilder: BuilderProtocol {
    var product: ConcreteProduct = ConcreteProduct(partA: "", partB: "")
    
    func buildPartA(_ value: String) {
        product.partA = value
    }
    
    func buildPartB(_ value: String) {
        product.partB = value
    }
    
    func buildProduct() -> ConcreteProduct {
        return product
    }
}

// 导演类或使用类
class Director {
    let builder: any BuilderProtocol
    
    init(builder: any BuilderProtocol) {
        self.builder = builder
    }
    
    func constructProduct(with partA: String, partB: String) {
        builder.buildPartA(partA)
        builder.buildPartB(partB)
        let product = builder.buildProduct()
        product.showProduct()
    }
}


