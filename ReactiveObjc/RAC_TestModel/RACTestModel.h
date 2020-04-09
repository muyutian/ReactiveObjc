//
//  RACTestModel.h
//  ReactiveObjc
//
//  Created by zhangzy on 2020/4/9.
//  Copyright © 2020 张正宇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACTestModel : NSObject

@property (strong, nonatomic)NSString *name;

@property (strong, nonatomic)NSNumber *age;

+ (RACTestModel *)modelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
