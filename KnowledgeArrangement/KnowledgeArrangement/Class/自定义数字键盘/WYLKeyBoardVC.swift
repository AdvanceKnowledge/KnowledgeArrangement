//
//  WYLKeyBoardVC.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/7/27.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import UIKit


enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class WYLKeyBoardVC: ParentsVC {
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var myTextView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        weak var weakSelf = self
        self.myTextField.inputView = WYLNumberKeyboardView.init(self.myTextField, nil, { _ in
            print("提现金额: \(weakSelf!.myTextField.text!)元")

            weakSelf?.method()
            
        })
        
        self.myTextView.inputView = WYLNumberKeyboardView.init(nil, self.myTextView, { _ in
            print("提现金额: \(weakSelf!.myTextView.text!)元")
        })
        
        let subView = CALayer()
        subView.backgroundColor = UIColor.red.cgColor
        subView.bounds = CGRect(x: 0, y: 500, width: 100, height: 100)
        subView.position = CGPoint(x: 30, y: 500)
        subView.anchorPoint = CGPoint(x: 0, y: 1)
        self.view.layer.addSublayer(subView)
        
//        if #available(iOS 15.0, *) {
//            Task{
//                let str = await self.asynchronousMethod()
//                print(str)
//            }
//        }
    }
    
    func method() {
        do {
            try self.vend(Int(self.myTextField.text!)!)
        } catch VendingMachineError.invalidSelection {
            print("invalidSelection")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print(coinsNeeded)
        } catch VendingMachineError.outOfStock {
            print("outOfStock")
        } catch {
            
        }
    }
    
    func vend(_ number: Int) throws {
        
        guard number < 15 else {
            throw VendingMachineError.invalidSelection
        }
        
        guard number < 10 else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: number)
        }
        
        guard number < 5 else {
            throw VendingMachineError.outOfStock
        }
        
        print(number)
    }
    
    @available(iOS 15.0.0, *)
    func asynchronousMethod() async -> String {
        sleep(10)
        return "已经睡了10秒钟"
    }
    
}
