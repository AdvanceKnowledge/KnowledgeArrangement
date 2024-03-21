//
//  Parents_VC.swift
//  WYLSwift
//
//  Created by 王延磊 on 2018/10/30.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit
import SVProgressHUD
class ParentsVC: BaseVC {

    deinit {
        debugPrint("\(type(of: self))类销毁了")
    }
   
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.return_button()
        SVProgressHUD.dismiss()
        
        if #available(iOS 11.0, *) {
            self.view.backgroundColor = UIColor.init(named: "white")
        } else {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    /// 返回按钮
    func return_button() {
        let backBtn = UIButton.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0),
                                                       size: CGSize.init(width: 22, height: 22)))
        backBtn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        backBtn.setBackgroundImage(UIImage.init(named: "navigation_back_hl"), for: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(self.backAction), for: UIControl.Event.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
    }
    
    /// 返回点击事件实现
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        SVProgressHUD.dismiss()
    }
}
