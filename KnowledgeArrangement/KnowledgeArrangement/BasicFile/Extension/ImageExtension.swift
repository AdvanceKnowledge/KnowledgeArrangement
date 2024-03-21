//
//  ImageExtension.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2023/1/9.
//  Copyright © 2023 ProgrammerHome. All rights reserved.
//

import Foundation
import UIKit
enum ImageRoundedType {
    case Corner(corners: CGFloat)// 圆角
    case OvalIn(rect: CGRect)// 椭圆
    case TopLeft(cornerradii: CGSize)//左上角
    case TopRight(cornerradii: CGSize)//右上角
    case BottomLeft(cornerradii: CGSize)//左下角
    case BottomRight(cornerradii: CGSize)//右下角
    case ArcCenter//半圆
    case Circle//圆形
}
extension UIImage {
    
    func addCorner(roundedType: ImageRoundedType)-> UIImage {
        switch roundedType {
        case .Corner(let corners):
            return self.drawCorner(corners: corners)
        case .OvalIn(let rect):
            return self.drawOvalIn(rect: rect)
        case .TopLeft(let cornerradii)://左上角
            return self.drawTopLeft(cornerRadii: cornerradii)
        case .TopRight(let cornerradii)://右上角
            return self.drawTopRight(cornerRadii: cornerradii)
        case .BottomLeft(let cornerradii)://左下角
            return self.drawBottomLeft(cornerRadii: cornerradii)
        case .BottomRight(let cornerradii)://右下角
            return self.drawBottomRight(cornerRadii: cornerradii)
        case .ArcCenter://半圆
            return self.drawArcCenter()
        case .Circle://圆形
            return self.drawCircleImage()
        }
    }
    
    /// 添加圆角
    /// - Parameter corners: 圆角
    private func drawCorner(corners: CGFloat)-> UIImage {
        return self.deal(path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), cornerRadius: corners))
    }
    
    
    /// 椭圆
    private func drawOvalIn(rect: CGRect)-> UIImage {
        return deal(path: UIBezierPath(ovalIn: rect))
    }
    
    /// 左上角
    private func drawTopLeft(cornerRadii cornerradii: CGSize)-> UIImage {
        return drawRoundedRect(topLeft: true, topRight: false, bottomLeft: false, bottomRight: false, cornerRadii: cornerradii)
        
    }
    
    ///右上角
    private func drawTopRight(cornerRadii cornerradii: CGSize)-> UIImage {
        
        return drawRoundedRect(topLeft: false, topRight: true, bottomLeft: false, bottomRight: false, cornerRadii: cornerradii)
    }
    
    ///左下角
    private func drawBottomLeft(cornerRadii cornerradii: CGSize)-> UIImage {
        
        return drawRoundedRect(topLeft: false, topRight: false, bottomLeft: true, bottomRight: false, cornerRadii: cornerradii)
    }
    
    ///右下角
    private func drawBottomRight(cornerRadii cornerradii: CGSize)-> UIImage {
        return drawRoundedRect(topLeft: false, topRight: false, bottomLeft: false, bottomRight: true, cornerRadii: cornerradii)
    }
    
    
    /// 四个角的圆角
    private func drawRoundedRect(topLeft topleft: Bool? = true, topRight topright: Bool? = true, bottomLeft bottomleft: Bool? = true, bottomRight bottomright: Bool? = true, cornerRadii cornerradii: CGSize)-> UIImage {
        
        var sub: UInt?
        if topleft! {
            sub = UIRectCorner.topLeft.rawValue
        }
        if topright! {
            if sub == nil {
                sub = UIRectCorner.topRight.rawValue
            } else {
                sub = sub! | UIRectCorner.topRight.rawValue
            }
            
        }
        if bottomleft! {
            if sub == nil {
                sub = UIRectCorner.bottomLeft.rawValue
            } else {
                sub = sub! | UIRectCorner.bottomLeft.rawValue
            }
        }
        if bottomright! {
            if sub == nil {
                sub = UIRectCorner.bottomRight.rawValue
            } else {
                sub = sub! | UIRectCorner.bottomRight.rawValue
            }
            
        }
        let dinCorners = UIRectCorner(rawValue: sub!)
        return deal(path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), byRoundingCorners: dinCorners, cornerRadii: cornerradii))
    }
    
    
    /// 半圆
    private func drawArcCenter()-> UIImage {
        
        let side = min(self.size.width, self.size.height)
        
        return deal(path: UIBezierPath(arcCenter: CGPoint(x: side/2.0, y: 0), radius: side/2.0, startAngle: 0, endAngle: Double.pi, clockwise: true))
    }
    
    /// 圆形
    private func drawCircleImage()-> UIImage {
        let side = min(self.size.width, self.size.height)
   
        return self.deal(path: UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: side, height: side)))
    }
    
    private func deal(path: UIBezierPath)-> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width:  path.bounds.width, height: path.bounds.height), false, UIScreen.main.scale)
        UIGraphicsGetCurrentContext()?.addPath(path.cgPath)
        UIGraphicsGetCurrentContext()?.clip()
        let X = -(self.size.width -  path.bounds.width)/3.0
        let Y = -(self.size.height -  path.bounds.height)/2.0
        self.draw(in: CGRect(x: X, y: Y, width: self.size.width, height: self.size.height))
        UIGraphicsGetCurrentContext()?.drawPath(using: .stroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output ?? self
    }
}
