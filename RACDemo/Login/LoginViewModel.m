//
//  LoginViewModel.m
//  RACDemo
//
//  Created by DBC on 2018/12/15.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
// 处理登录按钮是否允许点击

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    // 处理登录按钮是否允许点击
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, name), RACObserve(self, pwd)] reduce:^id(NSString *name, NSString *pwd){
        return @(name.length && pwd.length);
    }];
    
    //处理登录点击
    // 创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // block 执行命令会调用
        // 事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            [subscriber sendNext:@"请求登录的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 处理登录请求返回结果
    // executionSignals 获取命令中的信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // skip 跳过未执行信号回调
    [[command.executing skip:1]subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            // 正在执行
            NSLog(@"正在执行");
            // 显示蒙版
            
        } else {
            // 执行完成
            // 隐藏蒙版
            NSLog(@"执行完成");
        }
    }];
    _loginCommand = command;
}

@end
