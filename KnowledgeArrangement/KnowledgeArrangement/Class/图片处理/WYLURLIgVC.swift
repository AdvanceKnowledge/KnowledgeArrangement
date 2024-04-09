//
//  WYURLIgVC.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2024/3/28.
//  Copyright © 2024 ProgrammerHome. All rights reserved.
//

import UIKit

class WYLURLIgVC: ParentsVC {
    
    override func loadView() {
        let scrollView = UIScrollView()
        self.view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dic = [["title":"圆形",
                    "roundedType":ImageRoundedType.Circle,
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"],
                   ["title":"圆角",
                    "roundedType":ImageRoundedType.Corner(corners: 30),
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"
                   ],
                   ["title":"椭圆",
                    "roundedType":ImageRoundedType.OvalIn(rect: CGRect(x: 0, y: 0, width: 150, height: 100)),
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"],
                   
                   ["title":"左上角",
                    "roundedType":ImageRoundedType.TopLeft(cornerradii: CGSize(width: 50, height: 50)),
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"],
                   ["title":"右上角",
                    "roundedType":ImageRoundedType.TopRight(cornerradii: CGSize(width: 50, height: 50)),
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"],
                   ["title":"左下角",
                    "roundedType":ImageRoundedType.BottomLeft(cornerradii: CGSize(width: 50, height: 50)),
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"],
                   ["title":"右下角",
                    "roundedType":ImageRoundedType.BottomRight(cornerradii: CGSize(width: 50, height: 50)),
                    "url":"https://img95.699pic.com/photo/50047/8862.jpg_wh300.jpg"],
                   ["title":"左半圆",
                    "roundedType":ImageRoundedType.ArcCenter(direction: Direction.LEFT),
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"],
                   ["title":"右半圆",
                    "roundedType":ImageRoundedType.ArcCenter(direction: Direction.RIGHT),
                    "url":"https://i.pinimg.com/736x/b9/15/8e/b9158efac8fe9ba0ad73d18e63569ec8.jpg"],
                   ["title":"上半圆",
                    "roundedType":ImageRoundedType.ArcCenter(direction: Direction.TOP),
                    "url":"https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800"],
                   ["title":"下半圆",
                    "roundedType":ImageRoundedType.ArcCenter(direction: Direction.BOTTOM),
                    "url":"https://i.pinimg.com/736x/b9/15/8e/b9158efac8fe9ba0ad73d18e63569ec8.jpg"]]
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        var bottom = self.view.snp.top
        dic.forEach { item in
            let url = URL(string: item["url"] as? String ?? "")!
            
            let subView = createIV(title: item["title"] as? String ?? "",
                                   url: url,
                                   roundedType: item["roundedType"] as? ImageRoundedType ?? ImageRoundedType.Circle)
            self.view.addSubview(subView)
            subView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(bottom).offset(10)
                make.width.height.equalTo(375)
            }
            bottom = subView.snp.bottom
        }
        
        let url = URL(string: "https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg?auto=compress&cs=tinysrgb&w=800")!
        let left = createIV(title: "左半圆", url: url, roundedType: ImageRoundedType.ArcCenter(direction: Direction.LEFT))
        let right = createIV(title: "左半圆", url: url, roundedType: ImageRoundedType.ArcCenter(direction: Direction.RIGHT))
        self.view.addSubview(left)
        left.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bottom).offset(10)
            make.width.height.equalTo(375)
        }
        left.addSubview(right)
        right.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.subviews.last!.snp.bottom)
        }
        
    }
    
    func createIV(title: String,url: URL, roundedType: ImageRoundedType)->UIView {
        let markLab1 = UILabel.init()
        markLab1.text = title
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        UIImage.downloadImageWithUrl(url: url, roundedType: roundedType) { img in
            if img != nil {
                iv.image = img!
            }
        }
        iv.addSubview(markLab1)
        markLab1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(30)
            
        }
        return iv
    }
}
