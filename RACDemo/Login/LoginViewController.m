//
//  LoginViewController.m
//  RACDemo
//
//  Created by DBC on 2018/12/15.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "LoginViewController.h"
#import "ReactiveObjC.h"
#import "LoginViewModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation LoginViewController

-(LoginViewModel *)loginVM{
    if (_loginVM == nil) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // MVVM:
    // VM 视图模型, 处理界面上所有的业务逻辑
    // 每一个控制器对应一个VM
    // VM 里最好不要包括视图
    [self bindViewModel];
    
    [self loginEvent];
    // MVVM: 1.先创建VM模型, 把整个界面的一些业务逻辑处理完
    
    // 2.回到控制器去执行
    
//    // 处理文本框业务逻辑
//    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[_nameField.rac_textSignal, _pwdField.rac_textSignal] reduce:^id(NSString *name, NSString *pwd){
//        return @(name.length && pwd.length);
//    }];
//    // 按钮是否可点击
//    RAC(_loginBtn, enabled) = loginEnableSignal;
    
    // 创建命令
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        // block 执行命令会调用
//        // 事件处理
//        // 发送登录请求
//        NSLog(@"发送登录请求");
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            // 发送数据
//            [subscriber sendNext:@"请求登录的数据"];
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
//    // executionSignals 获取命令中的信号源
//    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
//
//    // skip 跳过未执行信号回调
//    [[command.executing skip:1]subscribeNext:^(NSNumber * _Nullable x) {
//        if ([x boolValue]) {
//            // 正在执行
//            NSLog(@"正在执行");
//            // 显示蒙版
//
//        } else {
//            // 执行完成
//            // 隐藏蒙版
//            NSLog(@"执行完成");
//        }
//    }];
    
    
}
// 绑定viewModel
-(void)bindViewModel{
    // 1. 给视图模型的账号密码绑定信号
    RAC(self.loginVM, name) = _nameField.rac_textSignal;
    RAC(self.loginVM, pwd) = _pwdField.rac_textSignal;
}

// 登录事件
-(void)loginEvent{
    // 按钮是否可点击
    RAC(_loginBtn, enabled) = self.loginVM.loginEnableSignal;
    
    // d监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击登录按钮");
        // 处理登录事件 命令类
        [self.loginVM.loginCommand execute:nil];
    }];
}

@end
