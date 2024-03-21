//
//  AGBaseView.swift
//  IOSAgent
//
//  Created by 无名 on 2020/4/17.
//  Copyright © 2020 无名. All rights reserved.
//

import UIKit
@objc protocol BaseViewDelegate: NSObjectProtocol {
    /// view 点击回调
    /// - Parameter view: 被点击的view
    /// - Parameter selectType: 点击类型
    /// - Parameter object: 携带参数
    @objc optional func view(_ view: UIView, selectType: String, object: Any?)
    
}
class AGBaseView: UIView {
    weak var baseViewDelegate: BaseViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainUI()
    }
    func mainUI() {
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
