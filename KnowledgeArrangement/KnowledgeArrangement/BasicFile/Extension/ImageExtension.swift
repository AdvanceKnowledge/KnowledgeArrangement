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
    case Corner(corners: CGFloat) // 圆角
    case OvalIn(rect: CGRect) // 椭圆
    case TopLeft(cornerradii: CGSize) // 左上角
    case TopRight(cornerradii: CGSize) // 右上角
    case BottomLeft(cornerradii: CGSize) // 左下角
    case BottomRight(cornerradii: CGSize) // 右下角
    case ArcCenter(direction: Direction) // 半圆
    case Circle // 圆形
}

enum Direction {
    case LEFT
    case RIGHT
    case TOP
    case BOTTOM
}

extension UIImage {
    
    /// 下载网络图,并添加圆角
    /// - Parameters:
    ///   - url: 图片地址
    ///   - roundedType: 圆角类型
    ///   - succ: 图片回调
    class func downloadImageWithUrl(url: URL,roundedType: ImageRoundedType , succ: @escaping (UIImage?)->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                succ(nil)
                return
            }
            DispatchQueue.main.async() {
                succ(image.addCorner(roundedType: roundedType))
            }
        }.resume()
    }
    
    func addCorner(roundedType: ImageRoundedType) -> UIImage {
        switch roundedType {
        case let .Corner(corners):
            return drawCorner(corners: corners)
        case let .OvalIn(rect):
            return drawOvalIn(rect: rect)
        case let .TopLeft(cornerradii): // 左上角
            return drawTopLeft(cornerRadii: cornerradii)
        case let .TopRight(cornerradii): // 右上角
            return drawTopRight(cornerRadii: cornerradii)
        case let .BottomLeft(cornerradii): // 左下角
            return drawBottomLeft(cornerRadii: cornerradii)
        case let .BottomRight(cornerradii): // 右下角
            return drawBottomRight(cornerRadii: cornerradii)
        case let .ArcCenter(direction): // 半圆
            return drawArcCenter(direction: direction)
        case .Circle: // 圆形
            return drawCircleImage()
        }
    }

    /// 添加圆角
    /// - Parameter corners: 圆角
    private func drawCorner(corners: CGFloat) -> UIImage {
        return deal(path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0,
                                                           width: size.width,
                                                           height: size.height), cornerRadius: corners))
    }

    /// 椭圆
    private func drawOvalIn(rect: CGRect) -> UIImage {
        return deal(path: UIBezierPath(ovalIn: rect))
    }

    /// 左上角
    private func drawTopLeft(cornerRadii cornerradii: CGSize) -> UIImage {
        return drawRoundedRect(topLeft: true,
                               topRight: false,
                               bottomLeft: false,
                               bottomRight: false,
                               cornerRadii: cornerradii)
    }

    /// 右上角
    private func drawTopRight(cornerRadii cornerradii: CGSize) -> UIImage {
        return drawRoundedRect(topLeft: false, topRight: true, bottomLeft: false, bottomRight: false, cornerRadii: cornerradii)
    }

    /// 左下角
    private func drawBottomLeft(cornerRadii cornerradii: CGSize) -> UIImage {
        return drawRoundedRect(topLeft: false,
                               topRight: false,
                               bottomLeft: true,
                               bottomRight: false,
                               cornerRadii: cornerradii)
    }

    /// 右下角
    private func drawBottomRight(cornerRadii cornerradii: CGSize) -> UIImage {
        return drawRoundedRect(topLeft: false,
                               topRight: false,
                               bottomLeft: false,
                               bottomRight: true,
                               cornerRadii: cornerradii)
    }

    /// 四个角的圆角
    private func drawRoundedRect(topLeft topleft: Bool? = true,
                                 topRight topright: Bool? = true,
                                 bottomLeft bottomleft: Bool? = true,
                                 bottomRight bottomright: Bool? = true,
                                 cornerRadii cornerradii: CGSize) -> UIImage {
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
        return deal(path: UIBezierPath(roundedRect: CGRect(x: 0,
                                                           y: 0,
                                                           width: size.width,
                                                           height: size.height),
                                       byRoundingCorners: dinCorners,
                                       cornerRadii: cornerradii))
    }

    /// 半圆
    private func drawArcCenter(direction: Direction) -> UIImage {
        //        其中arcCenter指圆心坐标，radius指圆的半径，startAngle指圆弧的起始角度，endAngle指圆弧的结束角度，clockwise指是否顺时针方向绘制。其中圆弧的角度参考系如下
        let side = min(size.width, size.height)
        var arcCenter = CGPoint(x: side / 2.0, y: side / 2.0)
        let radius = side / 2.0
        var startAngle = Double.pi * 1.5
        var endAngle = 0.5 * Double.pi
        var clockwise = true
        switch direction {
        case .LEFT:
            startAngle = 0.5 * Double.pi
            endAngle = Double.pi * 1.5
        case .RIGHT:
            arcCenter = CGPoint(x: 0, y: side / 2.0)
            startAngle = Double.pi * 1.5
            endAngle = 0.5 * Double.pi
        case .TOP:
            startAngle = Double.pi
            endAngle = 0
        case .BOTTOM:
            arcCenter = CGPoint(x: side / 2.0, y: 0)
            startAngle = 0
            endAngle = Double.pi
        }
        return deal(path: UIBezierPath(arcCenter: arcCenter,
                                       radius: radius,
                                       startAngle: startAngle,
                                       endAngle: endAngle,
                                       clockwise: clockwise))
    }

    /// 圆形
    private func drawCircleImage() -> UIImage {
        let side = min(size.width, size.height)

        return deal(path: UIBezierPath(ovalIn: CGRect(x: 0, y: 0,
                                                      width: side,
                                                      height: side)))
    }

    private func deal(path: UIBezierPath) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: path.bounds.width,
                                                      height: path.bounds.height),
                                               false,
                                               UIScreen.main.scale)
        UIGraphicsGetCurrentContext()?.addPath(path.cgPath)
        UIGraphicsGetCurrentContext()?.clip()
        let X = -(size.width - path.bounds.width) / 3.0
        let Y = -(size.height - path.bounds.height) / 2.0
        draw(in: CGRect(x: X, y: Y, width: size.width, height: size.height))
        UIGraphicsGetCurrentContext()?.drawPath(using: .stroke)

        let output = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        return output ?? self
        
    }
}
