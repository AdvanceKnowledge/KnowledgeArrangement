//
//  WYLThreadLockVC.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/7/22.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import UIKit
/**
1、自旋锁:
            1、果自旋锁被别的执行单元保持,调用者就一直循环在哪里,时刻监听自旋锁的保持者是否已经释,其作用是为了解决某项资源的互斥使用。因为自旋锁不会引起调用者睡眠，所以自旋锁的效率远 高于互斥锁
 
        缺点: 1.2、自旋锁一直占用CPU，他在未获得锁的情况下，一直运行－－自旋，所以占用着CPU，如果不能在很短的时 间内获得锁，这无疑会使CPU效率降低。
            2.2、在用自旋锁时有可能造成死锁，当递归调用时有可能造成死锁，调用有些其他函数也可能造成死锁，如 copy_to_user()、copy_from_user()、kmalloc()等。
        适用情况:  自旋锁只有在内核可抢占式或者 SMP 的情况下才真正需要   (SMP 是指在一个计算机上汇集了一组处理器（多CPU），各CPU之间共享内存子系统以及总线结构)
 
2、互斥锁:
        它们分别运行在Core0和 Core1上。假设线程A想要通过pthread_mutex_lock操作去得到一个临界区的锁，而此时这个锁正被线程B所持有，那么线程A就会被阻塞 (blocking)，Core0 会在此时进行上下文切换(Context Switch)将线程A置于等待队列中，此时Core0就可以运行其他的任务(例如另一个线程C)而不必进行忙等待。

 
3、两种锁的加锁原理
        3.1、互斥锁：线程会从sleep（加锁）——>running（解锁），过程中有上下文的切换，cpu的抢占，信号的发送等开销。
        3.2、自旋锁：线程一直是running(加锁——>解锁)，死循环检测锁的标志位，机制不复杂
 **/



class WYLThreadLockVC: ParentsVC {
    var ticketMutex = pthread_mutex_t()
    
//    pthread_spin_lock

    
    /// 50 张票
    var ticketsCount = 50
    private let taskLock = NSLock()
    
    
    
    override init() {
        super.init()
        // 初始化属性
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr)
//        PTHREAD_MUTEX_DEFAULT
//        PTHREAD_MUTEX_RECURSIVE 递归锁, 允许同一个线程对同一把锁进行重复加锁。要考重点同一个线程和同一把锁
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT)
        // 初始化锁
        pthread_mutex_init(&(self.ticketMutex), &attr)
        // 销毁属性
        pthread_mutexattr_destroy(&attr)
//        CFDictionarySetValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<self.ticketsCount {
            DispatchQueue.global().async {
                
                self.sellingTickets()
            }
        }
    }
    /// 买票动作
    func sellingTickets() {
//        taskLock.lock()
        pthread_mutex_lock(&self.ticketMutex)
        var oldCount = self.ticketsCount
        usleep(20000)
        oldCount -= 1
        self.ticketsCount = oldCount
        print("当前剩余票数-> %d", oldCount)
        pthread_mutex_unlock(&self.ticketMutex)
//        taskLock.unlock()
    }
}
