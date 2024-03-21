//
//  Custom_Btn.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/3/6.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit

class Custom_Btn: UIButton {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 {
            return nil
        }
        if self.point(inside: point, with: event) {
            weak var hit:UIView? = nil
            for view in self.subviews{
                //坐标转换
                let vonverPoint:CGPoint = self.convert(point, to: view);
                hit = view.hitTest(vonverPoint, with: event)
                if hit != nil {
                    break
                }
            }
            if hit != nil {
                return hit
            }else{
                return self
            }
        }
        return nil
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let X1:CGFloat = point.x
        let Y1:CGFloat = point.y
        let X2:CGFloat = self.frame.size.width/2
        let Y2:CGFloat = self.frame.size.height/2
        //计算点击的点是否在规定的内切圆区域内
        let dis:Double = sqrt(Double(pow((X1 - X2), 2)) + Double(pow((Y1 - Y2), 2)))
        if dis <= Double(X2) {
            return true
        }else{
            return false
        }
    }
}
