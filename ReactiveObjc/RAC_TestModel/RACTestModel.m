//
//  RACTestModel.m
//  ReactiveObjc
//
//  Created by zhangzy on 2020/4/9.
//  Copyright © 2020 张正宇. All rights reserved.
//

#import "RACTestModel.h"

@implementation RACTestModel

+ (RACTestModel *)modelWithDictionary:(NSDictionary *)dic{
    RACTestModel *model = [[RACTestModel alloc]init];
    model.name = dic[@"name"];
    model.age = dic[@"age"];
    
    return model;
}

@end
