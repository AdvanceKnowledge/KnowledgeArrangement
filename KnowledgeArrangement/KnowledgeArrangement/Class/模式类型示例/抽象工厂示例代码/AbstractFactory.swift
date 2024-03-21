// 首先定义两个产品族的抽象产品协议

import ObjectiveC
protocol ProductA {
    func description() -> String
}

protocol ProductB {
    func description() -> String
}

// 创建两个产品族的具体产品
class ConcreteProductA1: ProductA {
    func description() -> String {
        return "This is a Concrete Product A1"
    }
}

class ConcreteProductB1: ProductB {
    func description() -> String {
        return "This is a Concrete Product B1"
    }
}

class ConcreteProductA2: ProductA {
    func description() -> String {
        return "This is a Concrete Product A2"
    }
}

class ConcreteProductB2: ProductB {
    func description() -> String {
        return "This is a Concrete Product B2"
    }
}

// 定义抽象工厂协议，声明可以创建两种产品的方法
protocol FactoryProtocol {
    associatedtype ProductAType: ProductA
    associatedtype ProductBType: ProductB
    
    func createProductA() -> ProductAType
    func createProductB() -> ProductBType
}

// 创建具体的工厂，实现抽象工厂协议
class ConcreteFactory1: FactoryProtocol {
    typealias ProductAType = ConcreteProductA1
    typealias ProductBType = ConcreteProductB1
    
    func createProductA() -> ProductAType {
        return ConcreteProductA1()
    }
    
    func createProductB() -> ProductBType {
        return ConcreteProductB1()
    }
}

class ConcreteFactory2: FactoryProtocol {
    typealias ProductAType = ConcreteProductA2
    typealias ProductBType = ConcreteProductB2
    
    func createProductA() -> ProductAType {
        return ConcreteProductA2()
    }
    
    func createProductB() -> ProductBType {
        return ConcreteProductB2()
    }
}


