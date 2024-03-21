//
//  RunLoopMode_VC.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/3/6.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//


/*
 滑动tableView时,定时器失效,解决办法
 
 * 用来控制一些特殊操作只能在指定模式下运行，一般可以通过指定操作的运行mode来控制执行时机，以提高用户体验
 * 系统默认注册了5个Mode
 * kCFRunLoopDefaultMode：App的默认Mode，通常主线程是在这个Mode下运行，对应OC中的：NSDefaultRunLoopMode
 * UITrackingRunLoopMode：界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他Mode影响
 * kCFRunLoopCommonModes:这是一个标记Mode，不是一种真正的Mode，事件可以运行在所有标有common modes标记的模式中，对应OC中的NSRunLoopCommonModes，带有common modes标记的模式有：UITrackingRunLoopMode和kCFRunLoopDefaultMode
 * UIInitializationRunLoopMode：在启动 App时进入的第一个 Mode，启动完成后就不再使用
 * GSEventReceiveRunLoopMode：接受系统事件的内部Mode，通常用不到
 
    当tableView滑动时,runloop的mode是UITrackingRunLoopMode,而timer是默认mode即kCFRunLoopDefaultMode,此时timer循环处理被中断,解决办法是将timer添加到kCFRunLoopCommonModes中
 
 注:
 1、CommonModes不是实际存在的一种mode
 2、是同步 Source/Timer/Observer 到多个 mode 中的一种技术方案
 
 
 SQ:怎样实现一个常驻线程
 AS:
    1、为当前线程开启一个RunLoop
    2、向该RunLoopt中添加一个 port/Source/timer/Observe等待维持RunLoop的时间循环
    3、启动该RunLoop
    4、注意,添加与使用必须使用同一个mode
 
 
 SQ:什么是  RunLoop  他是怎样做到有事做事,无事休息的
 AS:
    1、RunLoop 实际上是一个事件循环用以处理事件与消息
    2、在调用 RunLoop  run 方法时会调用系统的一个函数 msg_mach  同时发生了用户态向核心态,切换状态达到有事做事,无事休息的效果
 
 SQ:RunLoop与线程时怎样的一个关系
 AS:
    1、RunLoop与线程是一一对应的关系
    2、线程默认是没有RunLoop的,需要手动添加一个
 
 
 
 
 
 
 
 
 
 */
import UIKit

class RunLoopMode_VC: ParentsVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = UITableView()
        self.view.addSubview(tab)
        tab.delegate = self
        tab.dataSource = self
        tab.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-100)
        }
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "RunLoop")
        let lab = UILabel()
        self.view.addSubview(lab)
        lab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-30)
        }
        var numer = 1
        lab.text = "repeat-1"
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            numer = numer + 1
            lab.text = "repeats-\(numer)"
        }
        
        //使用 commonModes 技术方案同步 Source/Timer/Observer 到多个 mode,解决滑动timer停止工作的问题
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
        
        
        print(twoSum([1,2,3,5], 6))
        
        var dictory:NSDictionary = [:]
         dictory = ["key":"value"]
        
        var dic:[String:String?] = [:]
        dic = ["key":"value"]
        dic["key"] = Optional<Optional<String>>.none

     
        print(dic.hashValue)
    
       /* str1 = some {
            some = {
                _guts = {
                    _object = {
                        _object = {}
                    }
                    _otherBits = {
                        _value = 875770417
                    }
                }
            }
        }
        
         
 
        str2 = some {
            some = some {
                some = {
                    _guts = {
                        _object = {
                            _object = {}
                        }
                        _otherBits = {
                            _value = 875770417
                        }
                    }
                }
            }
        }
        */
    }
    
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let hasMap:NSMutableDictionary = NSMutableDictionary(capacity: 3)
        for i:Int in nums {
//            hasMap.setValue(nums.firstIndex(of: i)!, forKeyPath: "\(i)")
            
            let key:String = String.init(format: "%d", i)
            hasMap.setObject(nums.firstIndex(of: i)!, forKey:key as NSCopying)
            
        }
        for i in nums {
            let y:Int = target - i
            
            if (hasMap.object(forKey: "\(y)") != nil){
                return [nums.firstIndex(of: i)!,hasMap.object(forKey: "\(y)") as! Int]
            }
        }
        
        return []
    }
    
}


extension RunLoopMode_VC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunLoop")
        cell?.textLabel?.text = "\(indexPath.row)"
//        print(CFRunLoopGetCurrent())
        return cell!
    }
}


class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        for i in nums {
            let y:Int = target - i
            for z in nums{
                if y == z{
//                    let index1:Int =
                    let index1:Int = nums.firstIndex(of: i)!
                    
                    let index2:Int = nums.firstIndex(of: y)!
                    return [index1,index2]
                }
            }
        }
        return []
    }
}
