//
//  MerchantTypeRequestViewModel.m
//  RACDemo
//
//  Created by DBC on 2018/12/15.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "MerchantTypeRequestViewModel.h"
#import "AFNetworking.h"
@implementation MerchantTypeRequestViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    _requestcCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 执行命令
        // 发送请求
        NSLog(@"%@", input);
        // 创建信号
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 创建请求管理者
            NSString *url = @"https://test.dbc61.com/app/pub/getMerchantTypeList";
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@", responseObject[@"data"]);
                NSArray *dictArr = responseObject[@"data"];
                NSArray *modelArray = [[dictArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                    // 数据转模型
                    return [[NSObject alloc] init];
                }] array];
                [subscriber sendNext:modelArray];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            return nil;
        }];
        return signal;
    }];
}

@end
