//
//  UIColor+Extension.swift
//  MiddleMall
//
//  Created by 无名 on 2019/12/4.
//  Copyright © 2019 无名. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    public static func RGB(red: Float, green: Float, blue: Float, alp: Float) -> UIColor {
        return UIColor.init(red: CGFloat(red/255.0),
                            green: CGFloat(green/255.0),
                            blue: CGFloat(blue/255.0),
                            alpha: CGFloat(alp))
    }
    
    public static func RGB_One(value: Float, alp: Float) -> UIColor {
        return UIColor.init(red: CGFloat(value/255.0),
                            green: CGFloat(value/255.0),
                            blue: CGFloat(value/255.0),
                            alpha: CGFloat(alp))
    }
    
    /// 字符串转颜色
    ///
    /// - Parameter colorStr: 字符串,如#FFFFFF 或者 如#1a000000
    /// - Returns: 返回颜色
    class func CSSHex(_ colorStr: String) -> UIColor {
        var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cStr.hasPrefix("#") {
            let index = cStr.index(after: cStr.startIndex)
            //cStr = cStr.substring(from: index)
            cStr = String(cStr[index...])
        }
        if cStr.count == 6 {
            return color(cStr: cStr)
        }else if cStr.count == 8 {
            return colorWithAlpha(cStr: cStr)
        }else {
            return UIColor.black
        }
    }
    
    /// 6位字符串转颜色
    ///
    /// - Parameter cStr: 6位字符串转没有涉及透明度的颜色
    /// - Returns: 返回颜色
    private class func color(cStr: String) -> UIColor {
        var color = UIColor.white
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        //let rStr = cStr.substring(with: rRange)
        let rStr = String(cStr[rRange])
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        //let gStr = cStr.substring(with: gRange)
        let gStr = String(cStr[gRange])
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        //let bStr = cStr.substring(from: bIndex)
        let bStr = String(cStr[bIndex...])
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        return color
    }
    
    /// 8位字符串转颜色
    ///
    /// - Parameter cStr: 8位字符串转涉及透明度的颜色
    /// - Returns: 返回颜色
    private class func colorWithAlpha(cStr: String) -> UIColor {
        var color = UIColor.white
        let aRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let aStr = String(cStr[aRange])
        let rRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let rStr = String(cStr[rRange])
        let gRange = cStr.index(cStr.startIndex, offsetBy: 4) ..< cStr.index(cStr.startIndex, offsetBy: 6)
        let gStr = String(cStr[gRange])
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = String(cStr[bIndex...])
        var a:CUnsignedInt = 0, r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: aStr).scanHexInt32(&a)
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        return color
    }


}

extension UIImage {
    /// 改变图片颜色
    ///
    /// - Parameter toColor: 改变颜色
    /// - Returns: 改变后的图片
    func color(to: UIColor) -> UIImage {
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        to.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: .destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    public class func renderImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        context.setFillColor(color.cgColor);
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height));
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
