import UIKit

var str = "Hello, playground"


var dic:[String:String?] = [:]
dic = ["key":"value"]
dic["key"] = Optional<String>.none

// 定义产品接口：汽车
protocol Car {
    var name: String { get }
    var color: String { get set }
    var price: Double { get }
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

// 抽象工厂协议
protocol CarFactory {
    associatedtype CarType: Car
    func createCar(name: String, color: String) -> CarType
}

// 具体工厂1：生产轿车的工厂
class SedanCarFactory: CarFactory {
    typealias CarType = SedanCar
    
    func createCar(name: String, color: String) -> CarType {
        return SedanCar(name: name, color: color)
    }
}

// 具体工厂2：生产SUV的工厂
class SUVFactory: CarFactory {
    typealias CarType = SUV
    
    func createCar(name: String, color: String) -> CarType {
        return SUV(name: name, color: color)
    }
}
let sedanFactory = SedanCarFactory()
let sedan = sedanFactory.createCar(name: "Model S", color: "Blue")
print("Created car: \(sedan.name), Color: \(sedan.color), Price: \(sedan.price)")

let suvFactory = SUVFactory()
let suv = suvFactory.createCar(name: "Model X", color: "Black")
print("Created car: \(suv.name), Color: \(suv.color), Price: \(suv.price)")
