//
//  ViewController.m
//  ReactiveObjc
//
//  Created by zhangzy on 2020/3/27.
//  Copyright © 2020 张正宇. All rights reserved.
//

#import "ViewController.h"

#import "RACTestModel.h"

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
    
    //一、运行机制（信号）
    [self reactiveCocoa_signal];
    
    //二、数据处理类
    [self reactiveCocoa_dataProcessing];
}


#pragma marl - 运行机制(信号)
- (void)reactiveCocoa_signal{
    /**
     RAC是围绕信号（signal）来运行的，基本流程是：
     1、创建/获取信号 （冷信号）
     2、订阅信号 （热信号）
     3、发送信号
     */
    
    /**
     RACSignal 信号类
     这个类只是表示数据变化时，信号内部会发出数据，它本身不具备发送信号的能力，而是通过subscriber（订阅者）发出。
     默认一个信号都是冷信号，即使数据变化了也不会被触发，只有订阅了这个信号才会变成热信号，数据变化时才会触发。
     */
    //创建信号
    NSLog(@"初始化信号类");
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"创建信号");
        
        //发送信号 subscriber订阅者 通过保存的订阅者的Block进行回调
        NSLog(@"发送信号");
        [subscriber sendNext:@"rac_signal"];
        
        //发送完成
        NSLog(@"发送完成");

        [subscriber sendCompleted];
                
        //RACDisposable用于取消订阅以及清理资源，当信号发送完成或者发送错误时触发。
        return [RACDisposable disposableWithBlock:^{
           //取消订阅
            NSLog(@"信号销毁");
        }];
    }];
    
    //订阅信号，只有订阅之后才会激活信号 信号类保存订阅者的Block
    NSLog(@"订阅信号");
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到信号: %@",x);
    }];
    
    
    /**
     RACSubject 信号提供者
     这个类可以充当信号，也可以发送信号，在这里要注意先订阅再发送信号。
     */
    //创建信号
    RACSubject *subject = [RACSubject subject];
    
    //订阅
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者_1： %@",x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者_2： %@",x);
    }];
    
    //自己发送信号
    [subject sendNext:@"subject"];
    
    
    /**
     RACReplaySubject 信号重复提供者
     这个类是RACSubject的子类，但和RACSubject不同的是，这里可以先发送信号再订阅信号。并且，不论是第几次订阅，都会将之前发送的信号全部接收一遍。
     */
    //创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    //发送信号
    [replaySubject sendNext:@"signal_1"];
    [replaySubject sendNext:@"signal_2"];
    
    //订阅信号
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者_3： %@",x);
    }];
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者_4： %@",x);
    }];
    
    /**
     那么对于RACSubject的实际应用，我们可以用来替换代理，应用实例请查看“RAC_Delegate”。
     */
    
}


#pragma marl - RACTuple & RACSequence 数据处理类
/**
 RACTupele 元组类
 RACSequence RAC中的集合类，用于代替数组和字典，可以用来快速遍历
 
 元组
    1、元组中元素e个数固定，不允许增删。
    2、无需定义key，必要时也可以为数据命名。
    3、可以同时存储多种类型的元素且元素类型固定。
    4、适合同时遍历多元数据。
 */

- (void)reactiveCocoa_dataProcessing{
    /**
     快速遍历
     1、把数组 转成 集合RACSequence (.rac_sequence)
     2、把集合RACSequence转换成信号类 (rac_sequence.signal)
     3、订阅信号、激活信号、会把集合中的元素全部遍历出来
     */
    
    //遍历数组
    NSArray *dataArr = @[@1, @3, @5, @7, @9];
    [dataArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"遍历数组：  %@",x);
    }];
    
    //遍历字典
    NSDictionary *dataDic = @{@"name":@"xxx", @"age":@20};
    [dataDic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        /**
         遍历出来的 x 是元组RACTuple对象
         解包元组，会把元组中的值按顺序给参数里面的变量赋值
         */
        RACTupleUnpack(NSString *key, NSString *value) = (RACTuple *)x;
        /**
         相当于
         NSString *key = (RACTuple *)x(0);
         NSString *key = (RACTuple *)x(1);
         */
        NSLog(@"遍历字典  key： %@    value： %@",key,value);
    }];
    
    //RAC 字典转模型
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RACTest.plist" ofType:nil];
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *modelMuArr = [NSMutableArray array];
    [dicArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTestModel *model = [RACTestModel modelWithDictionary:x];
        [modelMuArr addObject:model];
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@",error);
    } completed:^{
        NSLog(@"完成字典转模型 ： %@",modelMuArr);
    }];
    
    //进阶写法
    /**
     map（映射）目的是把原始值value映射成一个新值
     array 将集合转化成数组
     底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并保存到新的数组中
     */
    
    NSArray *modelArr = [[dicArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [RACTestModel modelWithDictionary:value];
    }] array];
    
    NSLog(@"进阶  %@",modelArr);
}


@end
