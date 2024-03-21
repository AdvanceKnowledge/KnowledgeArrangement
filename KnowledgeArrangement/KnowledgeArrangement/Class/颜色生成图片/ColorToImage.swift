//
//  ColorToImage.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/3/12.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit

class ColorToImage: ParentsVC {
    let showIV = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
        
        
    }
    
    func UI() -> Void {
        var i = 0
        let width = (Const().SCREENWIDTH - 40)/3
        while i < 6 {
            let R:Float = getRGBValue()
            let G:Float = getRGBValue()
            let B:Float = getRGBValue()
            let view = UIView()
            view.backgroundColor = UIColor.RGB(R: R, G: G, B: B, Alp: 1)
            self.view.addSubview(view)
            
            view.snp.makeConstraints { (make) in
                make.width.equalTo(width)
                make.left.equalTo(self.view).offset(Float(Float(i % 3) * Float(width + 10) + Float(10)))
                make.top.equalTo(self.view).offset(i/3 * 60 + 10)
                make.height.equalTo(50)
            }
            weak var weakSelf = self
            view.bk_(whenTapped: {
                weakSelf?.createImage(view: view)
                })
            i += 1
        }
        
        self.view.addSubview(showIV)
        showIV.backgroundColor = UIColor.gray
        showIV.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.width.equalTo(200)
        }
//        let ircleIV = UIImageView.init(image: UIImage.init(named: "fnegjing")?.drawCorner(corners: 10))
//        ircleIV.contentMode = .scaleAspectFit
//        ircleIV.backgroundColor = .red
//        self.view.addSubview(ircleIV)
//        ircleIV.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(showIV.snp.bottom).offset(30)
//            make.width.equalTo(100)
//            make.height.equalTo(200)
//        }
//
        let subView = UIView()
        subView.backgroundColor = .red
        subView.bounds = CGRect(x: -50, y: 0, width: 50, height: 50)
        self.view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.equalTo(showIV.snp.bottom).offset(30)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        let sub_subView = UIView()
        sub_subView.backgroundColor = .green
        subView.addSubview(sub_subView)
        sub_subView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.height.width.equalTo(50)
        }
        

        
        
    }
    
    
    func createImage(view:UIView) -> Void {
        showIV.image = colorToImage(color: view.backgroundColor!, size: CGSize(width: 200.0, height: 200.0))
        
    }

    func colorToImage(color:UIColor,size:CGSize) -> UIImage {
        /*
         画方格,与本代码颜色转文字没有多少关系
         */
        let subRexts = NSMutableArray(capacity: 3)
        var i = 0
        let y:CGFloat = 9
        let speace:CGFloat = CGFloat((y - 1) * 5)
        let width:CGFloat = CGFloat((size.width - speace)/y),height:CGFloat = width
        while i < Int(pow(Double(y), 2)) {
            let rect = CGRect(x: CGFloat(Float(i%Int(y)) * Float(width + 5)), y: CGFloat(Float(i/Int(y)) * Float(height + 5)), width: width, height: height)
            subRexts.add(rect)
            i += 1
        }
        
        //创建图片
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()//创建图片上下文
        context?.setFillColor(color.cgColor)
        let rects:[CGRect] = subRexts as! [CGRect]
        
        context?.fill(rects)//可以放数组,也可以单独放一个rect
        /*
         //注释掉 context?.fill(rect)
         打开下边两行也可以
         let rect = CGRect(x: 0, y: 0, width: size.width - 50, height: size.height)
         context?.fill(rect)
         */
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        return image!
    }
    
    
    
    func getRGBValue() -> Float {
        let value:Float = Float(arc4random() % 255)
        return value
    }

}
