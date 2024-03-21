//
//  WYLFPSLabel.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/4/26.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit

class WYLFPSLabel: UILabel {
    var kSize = CGSize(width: 100, height: 20)
    var _font:UIFont!
    var _subFont:UIFont!
    var _link:CADisplayLink!
    var _count:UInt = 0
    var _lastTime:TimeInterval = 0
    var _llll:TimeInterval!
    
    deinit {
        _link.invalidate()
    }
    
    override init(frame: CGRect) {
        var frame2 = frame
        if (frame.size.height == 0 && frame.size.width == 0){
            frame2.size = kSize
        }
        super.init(frame: frame2)
        
        UI()
    }
    
    
    func UI() -> Void {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        self.adjustsFontSizeToFitWidth = true
        self.textColor = .red
        self.backgroundColor = UIColor.init(white: 0.00, alpha: 0.700)
        _font = UIFont.init(name: "Menlo", size: 14)
        
        
        if (_font != nil) {
            _subFont = UIFont.init(name: "Menlo", size: 4)
        } else {
            _font = UIFont.init(name: "Courier", size: 14)
            _subFont = UIFont.init(name: "Courier", size: 4)
        }
        weak var weakSelf = self
        _link = CADisplayLink.init(target: weakSelf as Any, selector: #selector(weakSelf?.tick(link:)))
        _link.add(to: RunLoop.main, forMode: .common)
    }
    
   
    
    @objc func tick(link:CADisplayLink) -> Void {
        if (_lastTime == 0){
            _lastTime = link.timestamp
            return
        }
        _count += 1
        let delta:TimeInterval = link.timestamp - _lastTime
        if (delta < 1) {return}
        _lastTime = link.timestamp
        let fps = Float(_count) / Float(delta)
        _count = 0;
        self.text = "   \(Int(round(fps)))" + "FPS   "
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
