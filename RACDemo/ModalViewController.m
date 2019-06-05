//
//  ModalViewController.m
//  RACDemo
//
//  Created by DBC on 2018/12/13.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "ModalViewController.h"
#import "ReactiveObjC.h"
@interface ModalViewController ()
@property (nonatomic, strong) RACSignal *signal;
@end

@implementation ModalViewController
- (void)dealloc
{
    NSLog(@"%s", __func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 解决循环引用
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        NSLog(@"%@", self);
        
        return nil;
    }];
    self.signal = signal;
    
    
    // 包装元组
    RACTuple *tuple = RACTuplePack(@1, @2);
    NSLog(@"%@", tuple);
    // 解包
    RACTupleUnpack(NSNumber *num1, NSNumber *num2) = tuple;
    NSLog(@"%@  %@", num1, num2);
}
- (IBAction)dismiss:(id)sender {
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
