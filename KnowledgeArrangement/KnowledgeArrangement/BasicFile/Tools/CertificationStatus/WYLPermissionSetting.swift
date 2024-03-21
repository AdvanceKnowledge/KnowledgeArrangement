//
//  WYLPermissionSetting.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2024/3/21.
//  Copyright © 2024 ProgrammerHome. All rights reserved.
//

import UIKit

class WYLPermissionSetting: NSObject {

    static func showAlertToDislayPrivacySettingWithTitle(title:String,
                                                         msg: String,
                                                         cancel:String,
                                                         setting:String){
        WYLPermissionSetting.showAlertToDislayPrivacySettingWithTitle(title: title, msg: msg, cancel: cancel, setting: setting, completion: nil)
    }
    
    static func showAlertToDislayPrivacySettingWithTitle(title:String,
                                                         msg: String,
                                                         cancel:String,
                                                         setting:String,
                                                         completion:(()->Void)?){
        let cancel_action = UIAlertAction(title: cancel, style: .cancel)
        let ok_action = UIAlertAction(title: setting, style: .default) { action in
            if completion != nil {
                completion!()
            }
            WYLPermissionSetting.displayAppPrivacySettings()
        }
        let alertVC = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        alertVC.addAction(cancel_action)
        alertVC.addAction(ok_action)
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.present(alertVC, animated: true)
        
    }
    static func displayAppPrivacySettings(){
        let url = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(url,options: [:]) { result in
            print("result ====== \(result)")
        }
    }
    
}
