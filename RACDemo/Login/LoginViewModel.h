//
//  LoginViewModel.h
//  RACDemo
//
//  Created by DBC on 2018/12/15.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
// 处理登录按钮是否允许点击
@property (nonatomic, strong, readonly) RACSignal *loginEnableSignal;

// 保存账号密码
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pwd;

// 登录按钮的命令
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
