//
//  ResponseArea_VC.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/3/6.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//



/*
 修改button的响应区域
 虚线内部是相应区域,虚线以外是非响应区域
 
 */


import UIKit
//import SVProgressHUD
import SVProgressHUD
class ResponseArea_VC: ParentsVC {
    let custom_Btn = Custom_Btn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//
//            self.edgesForExtendedLayout =UIRectEdgeNone;
//
//        }
//        
//        if self.responds(to: #selector(setter: self.edgesForExtendedLayout)) {
//            self.edgesForExtendedLayout = 
//        }
        
        
        let introduce_lab:UILabel = UILabel()
        introduce_lab.numberOfLines = 0
        introduce_lab.font = UIFont.systemFont(ofSize: 14)
        introduce_lab.textColor = UIColor.colorWithString(colorStr: "999999")
        introduce_lab.text = "\n修改button的响应区域\n虚线内部是响应区域,虚线以外是非响应区域"
        self.view.addSubview(introduce_lab)
        introduce_lab.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.7)
        }
        
        
        self.view.addSubview(custom_Btn)
        custom_Btn.addTarget(self, action: #selector(self.action), for: .touchUpInside)
        custom_Btn.setTitle("响应区域", for: .normal)
        custom_Btn.backgroundColor = UIColor.gray
        custom_Btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(200)
        }
        mark()
        
        self.view.layoutIfNeeded()
        print(custom_Btn)
    }
    
    
    @objc func action() -> Void {
        SVProgressHUD.showInfo(withStatus: "响应区域")
        WYLPermissionSetting.showAlertToDislayPrivacySettingWithTitle(title: "提示", msg: "去设置", cancel: "取消", setting: "设置")
    }
    
    func mark() -> Void {
        let path:UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 200, height: 200))
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        shapeLayer.position = CGPoint(x: 100, y: 100)//shapeLayer添加在那个控件上就以那个控件为坐标系统
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2.5;
        shapeLayer.lineCap = .round
        shapeLayer.lineDashPattern = [2.5,10];
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor;//填充颜色,不设置则为纯黑色
        
        custom_Btn.layer.addSublayer(shapeLayer)
    }
    

}
