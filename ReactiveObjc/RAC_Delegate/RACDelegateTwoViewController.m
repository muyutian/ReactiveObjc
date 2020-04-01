//
//  RACDelegateTwoViewController.m
//  ReactiveObjc
//
//  Created by zhangzy on 2020/4/1.
//  Copyright © 2020 张正宇. All rights reserved.
//

#import "RACDelegateTwoViewController.h"


@interface RACDelegateTwoViewController ()

@end

@implementation RACDelegateTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//返回
- (IBAction)back:(id)sender {
    //通知 发送信号
    if (self.subject) {
        [self.subject sendNext:@"Dis Back"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
