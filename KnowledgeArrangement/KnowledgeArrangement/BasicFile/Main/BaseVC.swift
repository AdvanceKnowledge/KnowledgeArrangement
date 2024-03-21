//
//  Base_VC.swift
//  WYLSwift
//
//  Created by 王延磊 on 2018/10/30.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit
import SnapKit
import BlocksKit
import IQKeyboardManagerSwift
import MJRefresh
import SVProgressHUD
import Alamofire

class BaseVC: UIViewController, NextVC {

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.view.backgroundColor = UIColor.init(named: "white")
        } else {
            self.view.backgroundColor = UIColor.white
        }
        
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
extension BaseVC: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        
        if viewController.isEqual(self) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)

        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if self.navigationController?.delegate != nil {
                if (self.navigationController?.delegate?.isEqual(self))! {
                    self.navigationController?.delegate = nil
                }
            }
            
        }
    }
}
