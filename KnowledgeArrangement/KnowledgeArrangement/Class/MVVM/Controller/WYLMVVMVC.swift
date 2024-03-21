//
//  WYLMVVMVC.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/7/26.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//


///MVVM 的优点:
///            1、低耦合,视图(view)可以独立于 model 的变化和修改,一个 viewmodel 可以绑定到不同的"view"上,当 view 变化的时候model 可以不变,当 model 变化的时候,view 也可以不变
///            2、可重用性: 可以把一些视图逻辑放在一个 viewModel 中,让很多 view 重用这段视图逻辑
///            3、独立开发,开发人员可以专注于业务逻辑和数据的开发（ViewModel），设计人员可以专注于页面设计，使用Expression Blend可以很容易设计界面并生成xml代码
///            4、可测试，界面向来是比较难于测试的，而现在测试可以针对ViewModel来写
///
///
/// MVP 的优点:
///           1、模型与视图完全分离,我们可以修改视图而不影响模型
///           2、可以更高效的使用模型,因为所有的交互都发生在一个地方---------Presenter内部
///           3、我们可以将一个Presenter用于多个视图，而不需要改变Presenter的逻辑，这个特性非常的有用，因为视图的变化总是比模型的变化频繁
///           4、把逻辑放在Presenter中，进行单元测试，脱离用户接口来测试这些逻辑
///MVC 的优点:
///          1 、耦合性低
///          2 、重用性高
///          3 、生命周期成本低
///          4 、MVC 模式使开发和维护用户接口的技术含量降低
///          5 、可维护性高
///          6 、部署快
///      MVC 的缺点:
///                 1 、不适合小型、中等规模的应用程序
///                 2 、视图和控制器之间过于紧密的连接
///                 3 、视图对模型数据的低效率访问



import UIKit
import PGNumberKeyboard

class WYLMVVMVC: ParentsVC {
    
    private let apiManager = APIManager()
    private(set) var windViewModel: WindViewModel?

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var coordLabel: UILabel!
    
    @IBOutlet weak var myTextField: UITextField!
    
    var searchResult: CurrentWeather? {
        didSet {
            
            guard let searchResult = searchResult else { return }
            windViewModel = WindViewModel.init(currentWeather: searchResult)
            DispatchQueue.main.async {
                self.updateLabels()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboard = PGNumberKeyboard.init(textField: self.myTextField)
        keyboard?.delegate = self
        
        myTextField.inputView = keyboard
        
    }

    @IBAction func getDataButtonPressed(_ sender: UIButton) {
        getWheather()
    }
}

extension WYLMVVMVC: PGNumberKeyboardDelegate {
    
    func editChanage(_ sender: Any!) {
        print(sender)
    }
    
    private func updateLabels() {
        guard let windViewModel = windViewModel else { return }
        locationLabel.text = windViewModel.locationString
        windSpeedLabel.text = windViewModel.windSpeedString
        windDirectionLabel.text = windViewModel.windDegString
        coordLabel.text = windViewModel.coordString
    }
    
    private func getWheather() {
        apiManager.getWeather { (weather, error) in
            if let error = error {
                print("Get weather error: \(error.localizedDescription)")
                return
            }
            guard let weather = weather  else { return }
            self.searchResult = weather
            print("Current Weather Object:")
            print(weather)
        }
    }
}
