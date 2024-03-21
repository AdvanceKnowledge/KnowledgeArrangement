//
//  Main_Tab_VC.swift
//  PreferencesInlearning
//
//  Created by 王延磊 on 2018/11/19.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.addVC()
    }
    
    /// 添加控制器
//    func addVC() {
//        let homeVC = AGHomeVC()
//        self.setVCTabBarItem(title: "房源",
//                             selectedImage: "Home_Select",
//                             image: "Home_Normal",
//                             currentVC: homeVC)
//        let homeNav = UINavigationController.init(rootViewController: homeVC)
//
////        let newsVC = AGChatVC()
////        self.setVCTabBarItem(title: "消息",
////                             selectedImage: "News_Select",
////                             image: "News_Normal",
////                             currentVC: newsVC)
////
////        let newsNav = UINavigationController.init(rootViewController: newsVC)
//
//        let weiDianVC = AGWeiDianVC()
//        self.setVCTabBarItem(title: "微店",
//                             selectedImage: "WeiDian_Select",
//                             image: "WeiDian_Normal",
//                             currentVC: weiDianVC)
//        let weiDianNav = UINavigationController.init(rootViewController: weiDianVC)
//
//        let mineVC = AGMineVC()
//        self.setVCTabBarItem(title: "我的",
//                             selectedImage: "Mine_Select",
//                             image: "Mine_Normal",
//                             currentVC: mineVC)
//
//        let mineNav = UINavigationController.init(rootViewController: mineVC)
//        self.addChild(weiDianNav)
//        self.addChild(homeNav)
////        self.addChild(newsNav)
//        self.addChild(mineNav)
//
//        self.tabBar.isTranslucent = false
//        self.tabBar.clipsToBounds = true
//
////        //统计未读消息数
////        let conversations = EMClient.shared()?.chatManager.getAllConversations()
////            as? [EMConversation] ?? [EMConversation]()
////        var unreadCount = 0
////        conversations.forEach { (conversation) in
////            unreadCount += Int(conversation.unreadMessagesCount)
////        }
////        if unreadCount > 0 {
////            newsVC.tabBarItem.badgeValue = "\(unreadCount)"
////        }
//    }
    
    //    设置TabBar样式
    func setVCTabBarItem(title: NSString,
                         selectedImage: String?,
                         image: String?,
                         currentVC: UIViewController) {
        currentVC.navigationItem.title = title as String
        currentVC.tabBarItem.title = title as String
        if Const.isNotStrEmpty(obj: selectedImage) {
            currentVC.tabBarItem.selectedImage = UIImage.init(named: selectedImage!)
        }
        if Const.isNotStrEmpty(obj: image) {
            currentVC.tabBarItem.image = UIImage.init(named: image!)
        }
        if #available(iOS 11.0, *) {
            //未选中的颜色
            self.tabBar.tintColor = UIColor.init(named: "222222")
            //选中的颜色
            self.tabBar.unselectedItemTintColor = UIColor.init(named: "153")
        } else {
            //未选中的颜色
            self.tabBar.unselectedItemTintColor = UIColor.RGB_One(value: 153, alp: 1)
            //选中的颜色
            self.tabBar.tintColor = UIColor.colorWithString(colorStr: "222222")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
