//
//  WYLChartVC.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/11/11.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import UIKit
import ORCharts

class WYLChartVC: ParentsVC {
    
    let orRingChartView = ORRingChartView()
    let orLineChartView = ORLineChartView()
    let values = [12.1,13.4,14]
    let ringColors: [[UIColor]] = [[.red],[.blue],[.cyan]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.RGB_One(value: 200, alp: 1)
        setupUI()
        orRingChartView.reloadData()
    }
    
    func setupUI() {
        let segmentControl = UISegmentedControl(items: ["Ring","Pie","Fan"])
        segmentControl.addTarget(self, action: #selector(chanValue(seg:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        
//        初始化图表样式并配置ORRingChartView
        configureRingChartView(style: ORRingChartStyle.init(0))
        self.view.addSubview(segmentControl)
        self.view.addSubview(orRingChartView)
        
        segmentControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(30)
        }
        
        orRingChartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(self.view.snp.width)
        }
        
//        configureLineChartView()
//        self.view.addSubview(orLineChartView)
//        orLineChartView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
////            make.top.equalTo(orRingChartView.snp.bottom).offset(30)
//            make.top.equalToSuperview().inset(30)
//            make.height.width.equalTo(self.view.snp.width)
//        }
    }
    
    @objc func chanValue(seg: UISegmentedControl) {
        
        orRingChartView.style = ORRingChartStyle.init(rawValue: UInt(seg.selectedSegmentIndex))
        orRingChartView.reloadData()
    }
    
    func configureRingChartView(style: ORRingChartStyle) {
        orRingChartView.style = style
        orRingChartView.config.startAngle = 0
        orRingChartView.config.ringLineWidth = 20
        orRingChartView.dataSource = self
    }
    
    
    func configureLineChartView() {
        orLineChartView.dataSource = self
        orLineChartView.delegate = self
        
    }
    
}

extension WYLChartVC:ORRingChartViewDatasource {
    func numberOfRings(of chartView: ORRingChartView) -> Int {
        return values.count
    }
    
    func chartView(_ chartView: ORRingChartView, valueAtRing index: Int) -> CGFloat {
        return values[index]
    }
    
    func chartView(_ chartView: ORRingChartView, lineColorForRingAtRing index: Int) -> UIColor {
        return ringColors[index][0]
    }
//
    func chartView(_ chartView: ORRingChartView, graidentColorsAtRing index: Int) -> [UIColor] {
        return ringColors[index]
    }
    
    func chartView(_ chartView: ORRingChartView, lineColorForInfoLineAtRing index: Int) -> UIColor {
        return .black
    }
    
    func chartView(_ chartView: ORRingChartView, viewForTopInfoAtRing index: Int) -> UIView {
        var infoView: UIView? = chartView.dequeueTopInfoView(at: index)
        if infoView == nil {
            infoView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        }
        
        guard let titleLabel = infoView!.viewWithTag(100) as? UILabel else {
            let newTitleLabel = UILabel()
            newTitleLabel.adjustsFontSizeToFitWidth = true
            newTitleLabel.tag = 100
            infoView!.addSubview(newTitleLabel)
            newTitleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            newTitleLabel.text = "\(values[index])%"
            return infoView!
        }
        
        titleLabel.text = "\(values[index])%"
        return infoView!
    }
    
    func viewForRingCenter(of chartView: ORRingChartView) -> UIView {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .red
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
        
    }
    
}

extension WYLChartVC: ORLineChartViewDelegate,ORLineChartViewDataSource {
    func numberOfHorizontalData(of chartView: ORLineChartView) -> Int {
        return values.count
    }
    
    func chartView(_ chartView: ORLineChartView, valueForHorizontalAt index: Int) -> CGFloat {
        return values[index]
    }
    
    
}
