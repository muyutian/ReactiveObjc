//
//  RACDelegateOneViewController.m
//  ReactiveObjc
//
//  Created by zhangzy on 2020/4/1.
//  Copyright © 2020 张正宇. All rights reserved.
//

#import "RACDelegateOneViewController.h"

#import "RACDelegateTwoViewController.h"

@interface RACDelegateOneViewController ()

@end

@implementation RACDelegateOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /**
    RACSubject替换代理
    我们用经典的ViewController跳转回传值得方式说明
    */
}

//跳转
- (IBAction)push:(id)sender {
    RACDelegateTwoViewController *twoVC = [[RACDelegateTwoViewController alloc]init];
    
    //设置代理信号 并 订阅信号
    twoVC.subject = [RACSubject subject];
    [twoVC.subject subscribeNext:^(id  _Nullable x) {
        //接收RACDelegateTwoViewController发送的信号
        NSLog(@"接收信号数据： %@",x);
    }];
    
    //跳转
    [self presentViewController:twoVC animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
