//
//  WYLOperator_VC.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/7/10.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit
import SVProgressHUD
//import RxCocoa
import RxCocoa

class WYLOperator_VC: ParentsVC {
    
    let inputField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
        
    }
    
    
       
    
    
    func UI() {
        let lab = UILabel()
        lab.text = """
        重载操作符 自定义操作符 系统中没有 "+*"操作符,重新定义
        
        precedencegroup DotProductPrecedence {
        
            associativity:none//结合性
            higherThan: MultiplicationPrecedence//优先级

        }

        """
        self.view.addSubview(lab)
        lab.numberOfLines = 0
        lab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        
        inputField.placeholder = "请输入邮箱,或其他"
        self.view.addSubview(inputField)
        inputField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(lab.snp_bottom).offset(30)
        }
        
        
        let titles = ["电话","邮箱","纯属字","身份证号","URL"]
        let width = CGFloat(CGFloat(Const().SCREENWIDTH - CGFloat(10 * titles.count) - 10.0)/CGFloat(titles.count))
        
        var i:Int = 0
        for title in titles{
            let start_btn = UIButton()
            start_btn.setTitle(title, for: .normal)
            start_btn.titleLabel?.adjustsFontSizeToFitWidth = true
            start_btn.setTitleColor(.black, for: .normal)
            start_btn.tag = i
            start_btn.addTarget(self,  action: #selector(check(btn:)), for: .touchUpInside)
            start_btn.backgroundColor = UIColor.RGB(R: 240, G: 240, B: 240, Alp: 1)
            self.view.addSubview(start_btn)
            start_btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(CGFloat(i) * (width + 10.0) + 10.0)
                make.width.equalTo(width)
                
                make.top.equalTo(inputField.snp_bottom).offset(30)
            }
            i += 1
        }
        
        
    }
    
    @objc func check(btn:UIButton) {
        let tag = btn.tag
        var message:String?
        switch tag{
        case 0:
            message = "电话"
            break
        case 1:
            message = "邮箱"
            break
        case 2:
            message = "纯数字"
            break
        case 3:
            message = "身份证号"
            break
        case 4:
            message = "连接"
            break
        default:
            break
        }
        
        if (inputField.text! =~ String.StringType(rawValue: tag)!){
            SVProgressHUD.showSuccess(withStatus: "输入的是\(message ?? "正确")")
        }else{
            SVProgressHUD.showInfo(withStatus: "不是\(message ?? "错误")")
        }
    }
}

