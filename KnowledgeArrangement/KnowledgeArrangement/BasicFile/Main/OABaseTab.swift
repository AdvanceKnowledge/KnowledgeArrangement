//
//  OABase_Tab.swift
//  CollaborativeOffice
//
//  Created by 无名 on 2019/7/13.
//  Copyright © 2019 CollaborativeOffice. All rights reserved.
//

import UIKit
import MJRefresh
@objc protocol BaseTabDelegate: NSObjectProtocol {
    
    /// 点击首页
    /// - Parameter type: 点击位置
    /// - Parameter indexPath: 点击下标
    @objc optional func tab(_ tab: OABaseTab, selectType: String, didSelectIndexPath index: IndexPath)
    
    /// 点击首页
    /// - Parameter type: 点击位置
    /// - Parameter indexPath: 点击下标
    
    /// 点击事件
    /// - Parameter tab: 被点击cell
    /// - Parameter selectType: 点击类型
    /// - Parameter object: 传递的参数
    @objc optional func tab(_ tab: OABaseTab, selectType: String, object: Any?)
    
    /// 滑动偏移量
    /// - Parameter tab: 滑动的视图
    /// - Parameter offset: 偏移量
    @objc optional func tab(_ tab: OABaseTab, topOffset offset: CGFloat)
    
}
/// 设置别名,省的每次都得写两遍
typealias TabDataSourceAndDelegate = UITableViewDelegate & UITableViewDataSource
class OABaseTab: UITableView {
    
    weak var baseDelegate: BaseTabDelegate?
    var refreshBlock: OneParameterBlock!
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
//        }
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 200
        
        createViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createViews()
        
    }
    
    func createViews() {
        let footerView = UIView(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: Double(Const().SCREENWIDTH),
                                              height: Const().kBottomSafeHeight))
        self.tableFooterView = footerView
        self.separatorColor = UIColor.RGB(red: 229, green: 231, blue: 239, alp: 1)
        self.showsVerticalScrollIndicator = false
    }
    
    /// 添加下拉刷新
    func addDownRefresh() {
        weak var weakSelf: OABaseTab! = self
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            if weakSelf.refreshBlock != nil {
                weakSelf.refreshBlock(MYENUM.DOWN)
            }
        })
    }
    
    /// 添加上拉刷新
    func addUpRefresh() {
        weak var weakSelf: OABaseTab! = self
        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            if weakSelf.refreshBlock != nil {
                weakSelf.refreshBlock(MYENUM.UP)
            }
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


public enum MYENUM: Int {
    
    enum Home {
        ///轮播
        case CYCEL
        
        ///首页item点击
        case HOMEITEM
        
        ///点击首页二手房
        case HOMESECOND
        
        ///点击首页新房
        case HOMENEWHOUSE
        
        ///点击首页租房
        case HOMERENTHOUSE
        
        ///点击首页列表
        case HOMELIST
        
        ///点击首页更多按钮
        case HOMEMORE
    }
    
    enum Detail {
        ///收藏
        case COLLECTION
        ///关闭
        case CLOSE
        ///分享
        case SHARE
        ///周边
        case SURROUNDING
        ///户型图
        case DOORMODEL
        ///优选顾问
        case GOODCONSULTANT
        ///楼盘评价
        case REMAKE
        ///更多二手房
        case MORESECONDHOUSE
        ///小区
        case COMMUNITY
        ///配套设施
        case SUPPORTINGFACILITIES
    }

    enum Login {
        ///登录
        case LOGIN
        
        ///注册
        case REGISTER
        
        ///获取验证码
        case GETCODE
        
        ///切换登录状态
        case CHANGELOGINWAY
        ///隐私政策
        case PRIVACYPOLICY
        ///服务协议
        case SERVICEAGRENNMENT
    }
    
    ///退出程序
    case LOGOUT

    ///点击分类
    case CLASSITEM
    
    ///加入购物车
    case ADDSHOPCART
    
    ///立即购买
    case BUYNOW
    
    ///下拉刷新
    case DOWN

    ///上拉刷新
    case UP
}
