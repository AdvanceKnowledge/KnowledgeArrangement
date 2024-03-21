//
//  WYLPermissionLocation.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2024/3/21.
//  Copyright © 2024 ProgrammerHome. All rights reserved.
//

import UIKit
import CoreLocation
#if !__IPHONE_14_0
let __IPHONE_14_0 = 140000
#endif
class WYLPermissionLocation: NSObject {
    static var share = WYLPermissionLocation()
    var locationManager:CLLocationManager
    private override init() {
        self.locationManager = CLLocationManager()
    }
    
    /// 确定用户是否开启定位服务
    /// - Returns: true已开启,false:未开启
    func isServicesEnabled()-> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    
    /// 确定用户是否开启定位服务
    /// - Returns: true已开启,false:未开启
    func authorized()-> Bool {
        if #available(iOS 14.0, *) {
            return self.locationManager.authorizationStatus == .authorizedWhenInUse || self.locationManager.authorizationStatus == .authorizedAlways
        }
        
        if #available(iOS 8.0, *) {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
        }
        return true
    }
    
    /// 判断是否开启定位权限
    /// - Parameter withBlcok: 回调
    func authorizeWithCompletion(_ withBlcok:((Bool)->Void)?) {
        if (withBlcok != nil) {
            withBlcok!(self.authorized())
        }
    }
}
