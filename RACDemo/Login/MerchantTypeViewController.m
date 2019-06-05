//
//  MerchantTypeViewController.m
//  RACDemo
//
//  Created by DBC on 2018/12/15.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "MerchantTypeViewController.h"

#import "ReactiveObjC.h"
#import "MerchantTypeRequestViewModel.h"

@interface MerchantTypeViewController ()
@property (nonatomic, strong) MerchantTypeRequestViewModel *requestVM;
@end

@implementation MerchantTypeViewController

- (MerchantTypeRequestViewModel *)requestVM{
    if (_requestVM == nil) {
        _requestVM = [[MerchantTypeRequestViewModel alloc] init];
    }
    return _requestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // https://test.dbc61.com/app/pub/getMerchantTypeList
    
    // MVVM + RAC
    //发送请求
    RACSignal *signal = [self.requestVM.requestcCommand execute:@{@"name":@"abc", @"id":@"12301"}];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    
//    // 创建请求管理者
//    NSString *url = @"https://test.dbc61.com/app/pub/getMerchantTypeList";
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
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
