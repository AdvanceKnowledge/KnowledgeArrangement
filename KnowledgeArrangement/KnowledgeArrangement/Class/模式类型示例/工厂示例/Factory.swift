//
//  Factory.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2024/3/12.
//  Copyright © 2024 ProgrammerHome. All rights reserved.
//

import Foundation
// 首先定义一个产品协议（Product），所有具体的产品类都需要遵循这个协议
protocol Product {
    func description() -> String
}

// 创建两个遵循Product协议的具体产品类
class ConcreteProductA: Product {
    func description() -> String {
        return "This is a Concrete Product A"
    }
}

class ConcreteProductB: Product {
    func description() -> String {
        return "This is a Concrete Product B"
    }
}

// 创建工厂类，提供方法来根据条件生成不同的产品
class Factory {
    static func createProduct(type: String) -> Product? {
        switch type {
        case "A":
            return ConcreteProductA()
        case "B":
            return ConcreteProductB()
        default:
            print("Invalid product type")
            return nil
        }
    }
}



/*
 在Swift中实现一个稍微复杂的工厂模式，
 我们可以考虑一个应用场景：创建不同类型的汽车
 （如普通轿车、SUV和电动车），每种汽车有不同的配置和价格计算方式。
 这里我们将使用抽象工厂方法来创建具体汽车类的实例。
 */

// 定义产品接口：汽车
protocol Car {
    var name: String { get }
    var color: String { get set }
    var price: Double { get }
    
     func getName()->String
}

extension Car{
    func getName()->String{
        return self.name
    }
}

// 具体产品1：轿车
class SedanCar: Car {
    let basePrice = 20000.0
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var name: String
    var color: String

    // 添加以下缺失的实现以符合Car协议
    var price: Double {
        return basePrice + calculateOptionsPrice()
    }
    
    private func calculateOptionsPrice() -> Double {
        // 这里可以添加选项计算逻辑，为了简化示例，我们返回固定值
        return 5000.0
    }
}

// 具体产品2：SUV
class SUV: Car {
    let basePrice = 30000.0
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }

    // SUV也需要实现这些属性以符合Car协议
    var name: String
    var color: String

    var price: Double {
        return basePrice + calculateOptionsPrice()
    }
    
    private func calculateOptionsPrice() -> Double {
        // SUV的选项计算可能不同，这里仍然返回固定值
        return 8000.0
    }
}


class ElectricVehicle: Car {
    
    let basePrice = 2000.0

    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    var name: String
    var color: String

    
    var price: Double {
        return basePrice + calculateOptionsPrice()
    }
    
    private func calculateOptionsPrice() -> Double {
        // SUV的选项计算可能不同，这里仍然返回固定值
        return 8000.0
    }
    
}


enum CarType: String {
    case SECDN = "轿车",
         SUV = "SUV",
         Electric = "电动车"
}

class SubCarFactory {
    static func createCar(type: CarType,name: String, color: String)->Car{
        switch type {
        case .SECDN:
            return SedanCar(name: name, color: color)
        case .SUV:
            return SUV(name: name, color: color)
        case .Electric:
            return ElectricVehicle(name: name, color: color)
        }
    }
}

