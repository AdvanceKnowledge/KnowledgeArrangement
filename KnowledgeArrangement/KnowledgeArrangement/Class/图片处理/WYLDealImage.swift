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
        
        let dic = [["title":"原图","roundedType": RoundedType.Master],
                   ["title":"圆形","roundedType": RoundedType.Circle],
                   ["title":"圆角","roundedType": RoundedType.Corner],
                   ["title":"椭圆","roundedType": RoundedType.ovalIn],
                   ["title":"左上角","roundedType": RoundedType.topLeft],
                   ["title":"左半圆","roundedType": RoundedType.drawArcCenter(direction: .LEFT)],
                   ["title":"右半圆","roundedType": RoundedType.drawArcCenter(direction: .RIGHT)],
                   ["title":"上半圆","roundedType": RoundedType.drawArcCenter(direction: .TOP)],
                   ["title":"下半圆","roundedType": RoundedType.drawArcCenter(direction: .BOTTOM)],
                   
        ]
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        var bottom = self.view.snp.top
        dic.forEach { item in
            let subView = createIV(title: item["title"] as? String, roundedType: item["roundedType"] as? RoundedType)
            self.view.addSubview(subView)
            subView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(bottom).offset(10)
            }
            bottom = subView.snp.bottom
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.subviews.last!.snp.bottom)
        }
        rightNavBtn()
    }
    
    
    func rightNavBtn() {
//        UIBarButtonItem
        let rightBtn = UIButton()
        rightBtn.setTitle("处理网页图片", for: .normal)
        rightBtn.setTitle("处理本地图片", for: .selected)
        rightBtn.setTitleColor(.blue, for: .normal)
        rightBtn.setTitleColor(.purple, for: .selected)
        rightBtn.addTarget(self, action: #selector(changeImgResource(btn: )), for: .touchUpInside)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    
    @objc func changeImgResource(btn: UIButton) {
        let urlVC = WYLURLIgVC()
        let navVC = TYNavigationController.init(rootViewController: urlVC)
        
        self.present(navVC, animated: true)
    }
    
    func createIV(title: String? = "", roundedType: RoundedType?  = RoundedType.Master)-> UIView {
        let markLab1 = UILabel.init()
        markLab1.text = title
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.RGB_One(value: 200, alp: 1)
        switch roundedType! {
        case .Corner:
            iv.image = UIImage.init(named: "star")?.addCorner(roundedType: .Corner(corners: 30))
        case .ovalIn:
            iv.image = UIImage.init(named: "star")?.addCorner(roundedType: .OvalIn(rect: CGRect(x: 0, y: 0, width: 175, height: 375)))
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
            make.bottom.centerX.equalToSuperview()
        }
        return contentView
    }
}
