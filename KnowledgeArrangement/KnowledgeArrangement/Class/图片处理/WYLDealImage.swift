//
//  WYLDealImage.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2023/1/9.
//  Copyright © 2023 ProgrammerHome. All rights reserved.
//

import UIKit

enum RoundedType {
    case Master//原图
    case Corner// 圆角
    case ovalIn// 椭圆
    case Circle//圆形
    case topLeft
    case drawArcCenter(direction: Direction)
    case url_ig
}


class WYLDealImage: ParentsVC {
    
    override func loadView() {
        let scrollView = UIScrollView()
        self.view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let masterView = createIV(title: "原图", roundedType: .Master)
        let circelView = createIV(title: "圆形", roundedType: .Circle)
        let cornerView = createIV(title: "圆角", roundedType: .Corner)
        let ovalInView = createIV(title: "椭圆", roundedType: .ovalIn)
        let topLeftView = createIV(title: "左上角", roundedType: .topLeft)
        let arcCenterView_left = createIV(title: "左半圆", roundedType: .drawArcCenter(direction: .LEFT))
        let arcCenterView_right = createIV(title: "右半圆", roundedType: .drawArcCenter(direction: .RIGHT))
        let arcCenterView_top = createIV(title: "上半圆", roundedType: .drawArcCenter(direction: .TOP))
        let arcCenterView_bottom = createIV(title: "下半圆", roundedType: .drawArcCenter(direction: .BOTTOM))
        
        let urlIGView_bottom = createIV(title: "网络图,下半圆", roundedType: .url_ig)
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        let subs = [masterView,
                    circelView,
                    cornerView,
                    ovalInView,
                    topLeftView,
                    arcCenterView_left,
                    arcCenterView_right,
                    arcCenterView_top,
                    arcCenterView_bottom,
                    urlIGView_bottom,
        ]
        
        var bottom = self.view.snp.top
        
        subs.forEach { sub in
            self.view.addSubview(sub)
            sub.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(bottom).offset(10)
            }
            bottom = sub.snp.bottom
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.subviews.last!.snp.bottom)
        }
    }
    
    
    func createIV(title: String, roundedType: RoundedType)-> UIView {
        let markLab1 = UILabel.init()
        markLab1.text = title
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.RGB_One(value: 200, alp: 1)
        switch roundedType {
        case .Corner:
            iv.image = UIImage.init(named: "star")?.addCorner(roundedType: .Corner(corners: 30))
        case .ovalIn:
            iv.image = UIImage.init(named: "star")?.addCorner(roundedType: .OvalIn(rect: CGRect(x: 0, y: 0, width: 150, height: 100)))
        case .Circle:
            iv.image = UIImage.init(named: "star")?.addCorner(roundedType: .Circle)
        case .topLeft:
            iv.image = UIImage.init(named: "star")?.addCorner(roundedType: .TopLeft(cornerradii: CGSize(width: 50, height: 50)))
        case .drawArcCenter(let direction):
            iv.image = UIImage.init(named: "star")?.addCorner(roundedType: .ArcCenter(direction: direction))
        case .Master:
            iv.image = UIImage.init(named: "star")!
        case .url_ig:
            let url = URL(string: "https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800")!
            UIImage.downloadImageWithUrl(url: url, roundedType: .ArcCenter(direction: .BOTTOM)) { img in
                if img != nil {
                    iv.image = img!
                }
            }
        }
        
        let contentView = UIView()
        
        contentView.addSubview(markLab1)
        contentView.addSubview(iv)
        markLab1.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            
        }
        
        iv.snp.makeConstraints { make in
            make.top.equalTo(markLab1.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.width.height.equalTo(375)
            //            make.height.width.equalTo(200)
            make.bottom.centerX.equalToSuperview()
            
        }
        
        return contentView
        
    }
    
}
