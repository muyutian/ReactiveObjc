//
//  ViewController.m
//  ReactiveObjc
//
//  Created by zhangzy on 2020/3/27.
//  Copyright © 2020 张正宇. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // RAC 函数式编程 以及 响应式编程
    
    /**
     函数式编程：对一段操作进行封装，拿到输入，得到结果。
     满足函数式编程的特点有：
     1、函数必须有入参，并且函数产出会根据入参的不同而变化。
     2、函数执行过程中不会对全局变量、外部属性等产生影响。
     3、代码量小、干净。
     
     响应式编程：数据和视图是同时发生，同时改变的，因此视图就是对数据的一个映射。
     特点：
     1、同步发生，结果会随着修改参数而实时、动态的变化。
     2、存在固定的映射关系。
     
     链式编程：关注于数据流和变化传播，通过点号将多个操作链接在一起成为一句代码。
     （具体实现关注Demo）
     */
    
    /**
     RAC
     在事件发生时立即做出响应，这种逻辑需要用到KVO进行监听，然后重新计算，而RAC是不管中间过程而直接去响应事件。
     在处理Target-Action，Delegate，KVO，Notification等等时，把监听代码以及响应在吗放在一起，无需跳入对应方法，代码简洁利于管理。
     
     */
    
    //实例
    
    //运行机制（信号）
    [self reactiveCocoa_signal];
}

#pragma marl - 运行机制(信号)
- (void)reactiveCocoa_signal{
    /**
     RAC是围绕信号（signal）来运行的，基本流程是：
     1、创建/获取信号 （冷信号）
     2、订阅信号 （热信号）
     3、发送信号
     */
    
    //创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"创建信号");
        
        //发送信号 subscriber订阅者
        [subscriber sendNext:@"rac_signal"];
        
        //发送完成
        [subscriber sendCompleted];
        
        //RACDisposable用于取消订阅以及清理资源，当信号发送完成或者发送错误时触发。
        return [RACDisposable disposableWithBlock:^{
           //取消订阅
            NSLog(@"信号销毁");
        }];
    }];
    
    //订阅信号，只有订阅之后才会激活信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号: %@",x);
    }];
}


@end
