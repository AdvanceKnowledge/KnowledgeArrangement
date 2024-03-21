//
//  Command.swift
//  HouseholdService
//
//  Created by 无名 on 2019/1/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit
import SVProgressHUD
class Command: NSObject {
    //检测是否登录
    static func detectLoginStatus() -> Bool {
        if (UserDefaults.standard.object(forKey: "user_id") != nil){
            return true
        }else{
            return false
        }
    }
    
    //修改导航卡兰
    static func globalStyleModification() -> Void {
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setMinimumDismissTimeInterval(0.35)
        
        UINavigationBar.appearance().barTintColor = .white
//        UIColor.RGB(R: 105, G: 157, B: 248, Alp: 1)
//            Const().mainColor
//            UIColor.colorWithString(colorStr: "E6E6E6")//背景颜色
        UINavigationBar.appearance().isTranslucent = false;//透明度
        
        let attributes = NSDictionary.init(objects: [UIColor.black,UIFont.boldSystemFont(ofSize: 20)], forKeys: [NSAttributedString.Key.foregroundColor as NSCopying,NSAttributedString.Key.font  as NSCopying])//字体样式
        UINavigationBar.appearance().titleTextAttributes = attributes as? [NSAttributedString.Key : Any]
        
        // 隐藏导航栏下面的线
        UINavigationBar.appearance().shadowImage = UIImage()

        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
}
