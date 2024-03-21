//
//  EnlargeEdge.swift
//  CFTimer_RunLoop
//
//  Created by 王延磊 on 2022/7/6.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import Foundation
import UIKit

private var topNameKey = 0
private var rightNameKey = 0
private var bottomNameKey = 0
private var leftNameKey = 0

extension UIButton {
    
    func setEnlargeEdge(_ size: CGFloat) {
        self.layoutIfNeeded()
        objc_setAssociatedObject(self, &topNameKey, NSNumber(value: Float(size)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &rightNameKey, NSNumber(value: Float(size)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &bottomNameKey, NSNumber(value: Float(size)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &leftNameKey, NSNumber(value: Float(size)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func setEnlargeEdge(_ top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
        self.layoutIfNeeded()
        objc_setAssociatedObject(self, &topNameKey, NSNumber(value: Float(top)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &rightNameKey, NSNumber(value: Float(right)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &bottomNameKey, NSNumber(value: Float(bottom)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &leftNameKey, NSNumber(value: Float(left)), .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func enlargedRect() -> CGRect {
        self.layoutIfNeeded()
        let topEdge = objc_getAssociatedObject(self, &topNameKey) as? NSNumber
        let rightEdge = objc_getAssociatedObject(self, &rightNameKey) as? NSNumber
        let bottomEdge = objc_getAssociatedObject(self, &bottomNameKey) as? NSNumber
        let leftEdge = objc_getAssociatedObject(self, &leftNameKey) as? NSNumber
        if ((topEdge != nil) && (rightEdge != nil) && (bottomEdge != nil) && (leftEdge != nil))
        {
            return CGRect(x: self.bounds.origin.x - CGFloat(leftEdge!.floatValue),
                          y: self.bounds.origin.y - CGFloat(topEdge!.floatValue),
                          width: self.bounds.size.width + CGFloat(leftEdge!.floatValue) + CGFloat(rightEdge!.floatValue),
                          height: self.bounds.size.height + CGFloat(topEdge!.floatValue) + CGFloat(bottomEdge!.floatValue));
        } else
        {
            return self.bounds;
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = enlargedRect()
        if rect.equalTo(bounds) {
            return super.point(inside: point, with: event)
        }
        return rect.contains(point) ? true : false
    }
    
}
