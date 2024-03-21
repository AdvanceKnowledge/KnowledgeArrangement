//
//  Const.swift
//  LearSwift
//
//  Created by 王延磊 on 2018/11/16.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit
import SVProgressHUD
//一个参数的闭包函数
typealias OneParameterBlock = (Any?) -> Void
typealias TwoParameterBlock = (Any?, Any?) -> Void
typealias HaveReturnValueParameterBlock = (Any?, Any?, Any?) -> Void

class Const: NSObject {
    
    /// 百度地图appkey
    static let baidumapAPPKEY = "p1b02GUrAdySgFRWoudzc1xMgGxXDZmi"
    
    /// 测试
//    let baseURL = "http://dev.jnhouse.com/v1/"
    
//    / 正式
    let baseURL = "http://api.jnhouse.com/v1/"
    /// 主题背景颜色
    let mainColor = UIColor.RGB_One(value: 255, alp: 1)
 
    /// 屏幕的宽
    let SCREENWIDTH = UIScreen.main.bounds.size.width

    /// 屏幕的高
    let SCREENHEIGHT = UIScreen.main.bounds.size.height
    
    /// 屏幕宽比例
    let PROPORTIONW = UIScreen.main.bounds.size.width/375
    
    /// 屏幕高比例
    let PROPORTIONH = UIScreen.main.bounds.size.height/667
    
    /// 获取当前版本号
    let BUNDLEVERSION = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")

    /// 获取设备版本的UUID
    let DIVUUID = UIDevice.current.identifierForVendor?.uuidString
    
    /// 判断是否是iPhoneX
    let kIsiPhoneX = (UIScreen.instanceMethod(for: #selector(getter: UIScreen.currentMode)) != nil) ?
        __CGSizeEqualToSize(CGSize.init(width: 375.0, height: 812.0), UIScreen.main.bounds.size):false

    /// iPhoneX顶部安全区域
    let kTopBarSafeHeight = ((UIScreen.instanceMethod(for: #selector(getter: UIScreen.currentMode)) != nil) ?
        (__CGSizeEqualToSize(CGSize.init(width: 375.0, height: 812.0), UIScreen.main.bounds.size) ||
            __CGSizeEqualToSize(CGSize.init(width: 414.0, height: 896.0), UIScreen.main.bounds.size)):false) ?
                24.0:0.0
    
    /// iPhoneX底部安全区域
    let kBottomSafeHeight = ((UIScreen.instanceMethod(for: #selector(getter: UIScreen.currentMode)) != nil) ?
        (__CGSizeEqualToSize(CGSize.init(width: 375.0, height: 812.0), UIScreen.main.bounds.size) ||
            __CGSizeEqualToSize(CGSize.init(width: 414.0, height: 896.0), UIScreen.main.bounds.size)):false) ?
                24.0:0.0

    /// 本地化导航栏标题
    /// - Parameter name: 标题名称
    /// - Parameter controller: 控制器
    static func navtitle(name: NSString, controller: UIViewController) {
        controller.navigationItem.title = NSLocalizedString(name as String, comment: "导航栏标题" )
    }

    /// 本地化导航栏标题
    /// - Parameter name: 名称
    static func WYLLocalString(name: NSString) -> NSString {
        return NSLocalizedString(name as String, comment: "本地化" ) as NSString
    }

    ///字符串不为空
    /// - Parameter obj: 需判断文本
    static func isYESStrEmpty(obj: String?) -> Bool {
        var result = Bool()

        result = obj == nil ||
        (obj?.isEqual(NSNull()))! ||
        (obj?.isEqual(""))! ||
        (obj?.isEqual("null"))!
        return result
    }

    /// 字符串为空
    /// - Parameter obj: 需判断文本
    static func isNotStrEmpty( obj: String?) -> Bool {
        let result = !(obj == nil) &&
            !(obj?.isEqual(NSNull()))! &&
            !(obj?.isEqual(""))! &&
            !(obj?.isEqual("null"))!

        return result
    }

    /// 计算缓存大小
    static func huanCun() -> String {
           var folderSize: CGFloat = 0.0

           //获取路径
           let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

           //获取所有文件的数组
           let files = FileManager.default.subpaths(atPath: cachePath ?? "")

           debugPrint(String(format: "文件数：%ld", files?.count ?? 0))
           
           for path in files ?? [] {
               let filePath = cachePath ?? "" + ("/\(path)")
               //累加
               do {
                   folderSize += CGFloat(try FileManager.default.attributesOfItem(atPath: filePath)[FileAttributeKey.size] as? UInt64 ?? 0)
               } catch {
               }
           }
           //转换为M为单位
           let sizeM = folderSize / 1024.0 / 1024.0
           
           let sizeStr = String.init(format: "%.2f", sizeM)
           return "\(sizeStr) M"
       }
    
    /// 清除缓存
    static func cleanCache(block: @escaping (_ result: Bool) -> Void) {
        //===============清除缓存==============
        //获取路径
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        //返回路径中的文件数组
        let files = FileManager.default.subpaths(atPath: cachePath)
        debugPrint(String(format: "文件数：%ld", files?.count ?? 0))
        for p in files ?? [] {
            
            let path = cachePath + ("/\(p)")
            if FileManager.default.fileExists(atPath: path) {
                var isRemove = false
                do {
                    try FileManager.default.removeItem(atPath: path)
                    isRemove = true
                } catch {
                }
                if isRemove {
                    SVProgressHUD.showSuccess(withStatus: "清除成功")
                    //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                } else {

                    SVProgressHUD.showInfo(withStatus: "清除失败")
                }
                block(isRemove)
            }
        }
    }
    
    /// 设置行间距
    /// - Parameter normalString: 需要设置行间距的文本
    /// - Parameter font: 字体大小
    /// - Parameter linspace: 期望行间距大小
    static func getAttributedStringWithNormalString(normalString: String,
                                                    font: CGFloat,
                                                    linspace: CGFloat) -> NSAttributedString {
        if normalString == "" {
            return NSAttributedString.init(string: "", attributes: [:])
        }
        let attributeDict = NSMutableDictionary.init(capacity: 3)
        attributeDict.setValue(UIFont.systemFont(ofSize: font),
                               forKey: NSAttributedString.Key.font.rawValue)
        let paraStyle = NSMutableParagraphStyle.init()
        paraStyle.lineSpacing = linspace

        attributeDict.setValue(paraStyle, forKey: NSAttributedString.Key.paragraphStyle.rawValue)
        return NSAttributedString.init(string: normalString as String,
                                       attributes: attributeDict as? [NSAttributedString.Key: Any])
    }

    /// 颜色生成图片
    /// - Parameter color: 颜色
    /// - Parameter size: 生成的图片大小
    static func colorToImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        //创建图片
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()//创建图片上下文
        context?.setFillColor(color.cgColor)//设置当前填充颜色的图形上下文
        context?.fill(rect)//填充颜色
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
}
