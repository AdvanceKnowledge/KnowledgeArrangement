# <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview



## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->

#什么是 runloop
    runloop 是事件接收和分发机制的一个实现,是线程相关基础框架的一部分,一个 runloop 就是一个事件处理的循环,用来不停地调度工作及处理输入事件``

#runloop 的主要目的
    保证程序执行的线程不会被系统终止,如果没有 runloop 那么 UIApplicationMain 函数执行结束后将直接返回,程序一启动然后就结束.再有工作的时候忙于工作,而没有工作的时候处于休眠状态
#什么时候使用 runloop
    当需要和该线程进行交互的时候才会使用 runloop(eg: 滑动页面同时倒计时,耗时线程操作.)
