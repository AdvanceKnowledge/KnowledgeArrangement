//
//  WYLDealImage.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2023/1/9.
//  Copyright © 2023 ProgrammerHome. All rights reserved.
//

import UIKit

enum RoundedType {
    case Corner// 圆角
    case ovalIn// 椭圆
    case Circle//圆形
    case topLeft
    case drawArcCenter
}


class WYLDealImage: ParentsVC {

    override func loadView() {
        let scrollView = UIScrollView()
        self.view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let circelView = createIV(title: "圆形", roundedType: .Circle)
        let cornerView = createIV(title: "圆角", roundedType: .Corner)
        let ovalInView = createIV(title: "椭圆", roundedType: .ovalIn)
        let topLeftView = createIV(title: "左上角", roundedType: .topLeft)
        let arcCenterView = createIV(title: "半圆", roundedType: .drawArcCenter)
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        let subs = [circelView,
                    cornerView,
                    ovalInView,
                    topLeftView,
                    arcCenterView
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
        iv.backgroundColor = UIColor.RGB_One(value: 200, alp: 1)
        switch roundedType {
        case .Corner:
            iv.image = UIImage.init(named: "fnegjing")?.addCorner(roundedType: .Corner(corners: 30))
        case .ovalIn:
            iv.image = UIImage.init(named: "fnegjing")?.addCorner(roundedType: .OvalIn(rect: CGRect(x: 0, y: 0, width: 150, height: 100)))
        case .Circle:
            iv.image = UIImage.init(named: "fnegjing")?.addCorner(roundedType: .Circle)
        case .topLeft:
            iv.image = UIImage.init(named: "fnegjing")?.addCorner(roundedType: .TopLeft(cornerradii: CGSize(width: 50, height: 50)))
        case .drawArcCenter:
            iv.image = UIImage.init(named: "fnegjing")?.addCorner(roundedType: .ArcCenter)
        }
        
        let contentView = UIView()
        
        contentView.addSubview(markLab1)
        contentView.addSubview(iv)
        markLab1.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            
        }
        
        iv.snp.makeConstraints { make in
            make.top.equalTo(markLab1.snp.bottom).offset(10)
            make.bottom.centerX.equalToSuperview()
            
        }
        
        return contentView
        
    }

}
