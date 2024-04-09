//
//  WYLLoadingView.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2024/3/28.
//  Copyright © 2024 ProgrammerHome. All rights reserved.
//

import UIKit
import UIKit

// 定义颜色常量
let KKhaki = UIColor(red: 205/255.0, green: 171/255.0, blue: 106/255.0, alpha: 1.0)
let shareLoading = WYLLoadingView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100)))

class WYLLoadingView: UIView {

    static let DURATION: TimeInterval = 3.0
    static let WIDTH_NORMAL: CGFloat = 22.0
    static let HEIGHT_NORMAL: CGFloat = 22.0
    static let LINE_WIDTH_NORMAL: CGFloat = 1.0
    static let WIDTH_BIG: CGFloat = 24.0
    static let HEIGHT_BIG: CGFloat = 24.0
    static let LINE_WIDTH_BIG: CGFloat = 3.0
    
    private var iconView = UIView()
    private var progressLayer: CAShapeLayer!
    private var rotateAnimation: CABasicAnimation!
    private var strokeAnimatinStart: CABasicAnimation!
    private var strokeAnimatinEnd: CABasicAnimation!
    private var animationGroup: CAAnimationGroup!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 205/255.0, green: 171/255.0, blue: 106/255.0, alpha: 0.3)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        isUserInteractionEnabled = false
        
        iconView = UIView()
//        iconView.layer.cornerRadius = 10
        iconView.backgroundColor = .clear
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        setupProgressLayer()
        addAnimationsToLayer()
        iconView.layer.addSublayer(progressLayer)
        self.stopProgressAnimating()
    }

    private func setupProgressLayer() {
        progressLayer = CAShapeLayer()
        progressLayer.bounds = CGRect(x: 0, y: 0, width: WYLLoadingView.WIDTH_BIG, height: WYLLoadingView.HEIGHT_BIG)
        progressLayer.path = UIBezierPath(arcCenter: CGPoint(x: WYLLoadingView.WIDTH_BIG/2, y: WYLLoadingView.HEIGHT_BIG/2), radius: (WYLLoadingView.WIDTH_BIG - WYLLoadingView.LINE_WIDTH_BIG) / 2, startAngle: -.pi/2, endAngle: 3 * .pi/2, clockwise: true).cgPath
        progressLayer.lineWidth = WYLLoadingView.LINE_WIDTH_BIG
        progressLayer.strokeColor = KKhaki.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0
        progressLayer.strokeStart = 0
        progressLayer.lineCap = .round
    }

    func setStrokeColor(_ strokeColor: UIColor) {
        self.strokeColor = strokeColor
        progressLayer.strokeColor = strokeColor.cgColor
    }

    var strokeColor: UIColor? {
        didSet {
            progressLayer.strokeColor = strokeColor?.cgColor
        }
    }

    func addAnimationsToLayer() {
        rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 2 * Double.pi
        rotateAnimation.duration = WYLLoadingView.DURATION / 2
        rotateAnimation.repeatCount = .infinity
        rotateAnimation.isRemovedOnCompletion = false

        strokeAnimatinStart = CABasicAnimation(keyPath: "strokeStart")
        strokeAnimatinStart.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeAnimatinStart.duration = WYLLoadingView.DURATION / 2
        strokeAnimatinStart.fromValue = 0
        strokeAnimatinStart.toValue = 0.95
        strokeAnimatinStart.beginTime = WYLLoadingView.DURATION / 2
        strokeAnimatinStart.isRemovedOnCompletion = false
        strokeAnimatinStart.fillMode = .forwards
        strokeAnimatinStart.repeatCount = .infinity

        strokeAnimatinEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimatinEnd.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeAnimatinEnd.duration = WYLLoadingView.DURATION
        strokeAnimatinEnd.fromValue = 0
        strokeAnimatinEnd.toValue = 0.95
        strokeAnimatinEnd.isRemovedOnCompletion = false
        strokeAnimatinEnd.fillMode = .forwards
        strokeAnimatinEnd.repeatCount = .infinity

        animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeAnimatinStart, strokeAnimatinEnd]
        animationGroup.repeatCount = .infinity
        animationGroup.duration = WYLLoadingView.DURATION
        progressLayer.add(rotateAnimation, forKey: "rotate")
        progressLayer.add(animationGroup, forKey: "group")
    }

    func startProgressAnimating() {
        iconView.isHidden = false
        progressLayer.isHidden = false
        let window = UIApplication.shared.keyWindow?.rootViewController
        window?.view.addSubview(shareLoading)
        shareLoading.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
    }

    func stopProgressAnimating() {
        iconView.isHidden = true
        progressLayer.isHidden = true
    }

    deinit {
        iconView.removeFromSuperview()
    }
}
