//
//  ViewController.m
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculater.h"
#import "UITableView+initial.h"
#import "FUNCCacalateManager.h"
#import "ReactiveObjC.h"
#import "NSObject+RACKVOWrapper.h"
#import "RedView.h"
#import "Flag.h"
#import "RACReturnSignal.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet RedView *redView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, strong) id<RACSubscriber> subscriber;
@end

@implementation ViewController

-(void)linkProgram{
    // 链式编程
    int result = [self dbc_makeCaculater:^(CaculaterManager * _Nonnull make) {
        make.add(6).add(7);
    }];
    NSLog(@"%d", result);
    
    UITableView *tableView = [UITableView dbc_makeUITableViewInitial:^(DBCTableViewManager * _Nonnull make) {
        make.name(@"UITableView");
        make.delegate(self);
        make.cellIdentify(@"UITableViewCell");
        make.registerCellClassName(@"UITableViewCell");
    }];
    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [self.view addSubview:tableView];
    [tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self linkProgram];
    
    // 函数式编程
    FUNCCacalateManager *caculate = [[FUNCCacalateManager alloc] init];
    int result = [[caculate caculate:^(int result){
        // 计算代码
        result += 5;
        result *= 5;
        return result;
    }] result];
    
    NSLog(@"%d", result);
    
    // RACSigal: 有数据产生的时候, 就使用RACSignal
    // 步骤: 1. 创建信号  2.订阅i信号   3.发送信号
    // 创建信号(冷信号)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // didSubscribe调用: 只要信号被订阅就好调用
        // didSubscribe作用: 发送数据
        // 发送信号
        [subscriber sendNext:@1];
        self.subscriber = subscriber;
        return [RACDisposable disposableWithBlock:^{
            // 只要信号取消订阅j, 就会被调用
            NSLog(@"信号被取消订阅了");
        }];
    }];

    
    // 订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        //nextBlock 调用:只要订阅者发送数据就会调用
        //nextBlock 作用:处理数据, 展示到UI上面
        NSLog(@"%@", x);
    }];
    // 订阅取消
    [disposable dispose];
    
    
    // racsubjet
    [self RACSubject];
    
    // racreplaysubject
    [self RACReplaySubject];
    
    //元组
    [self RACTuple];
    
    // 集合RACSequence
    [self RACSequence];
    
    // 解析数组
    [self parseArray];
    
    // 代替代理
    [self RACSubjectReplaceDelegate];
    [self RACDelegateEvent];
    
    // 代理KVO
    [self RACKVO];
    
    // 监听事件
    [self RACBtnClickEvent];
    
    // 代替通知
    [self RACNotification];
    
    // 监听文本框
    [self RACTextField];
    
    // 信号组合
    [self signalConcat];
    [self signalThen];
    [self signalMerge];
    [self signalZipWith];
    [self signalCombineLastest];
    
    // 多次请求
    [self liftSelector];
    
    // RAC宏的使用
    [self RACHong];
    
    
    // 解决信号被多次订阅,发送多次信号问题
    [self RACMulticastConnection];
    
    // RACCommand
    [self RACCommand];
    
    // 绑定信号
    [self RACBind];
    
    // 映射
    [self RACFlattenMap];
    [self RACMap];
    
    // 过滤
    [self RACFilter];
    // 忽略
    [self RACIgnore];
    
    [self RACTake];
    
    [self RACDistinctUntilChanged];
    
    [self RACSkip];
}

-(void)RACSubject{
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    // 订阅信号  不同订阅者z订阅的方式不一样
    // RACSubject处理订阅: 仅仅创建并保存订阅者
    RACDisposable *disposable1 = [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 发送数据
    [subject sendNext:@"123123"];
}

-(void)RACReplaySubject{
    // 创建信号
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    [subject sendNext:@"-00000000"];
    [subject sendNext:@"-11111111"];
    
    // 订阅信号
    // 保存订阅者   遍历所有的值并发送数据
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到信号: %@", x);
    }];
    // 发送信号 并保存值
    [subject sendNext:@"123456"];
    [subject sendNext:@"123456789"];
    
    // 可以先发送数据, 再订阅信号
}

-(void)RACSubjectReplaceDelegate{
    [self.redView.btnClockSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

// 元组
-(void)RACTuple{
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"1001", @"1002"]];
    NSString *str = tuple[0];
    NSLog(@"%@", str);
}

// RACSequence
-(void)RACSequence{
    NSArray *arr = @[@"2001", @"2002"];
    RACSequence *seque = arr.rac_sequence;
    
    // 遍历  把集合转换成信号
    RACSignal *signal = seque.signal;
    // 订阅集合信号, 内部自动遍历所有元素发出来
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"集合信号%@", x);
    }];
    
    // 等效上面
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    
    NSDictionary *dic = @{@"key":@"value", @"name":@"abc"};
    [dic.rac_sequence.signal subscribeNext:^(RACTuple *x) {
//        NSString *key = x[0];
//        NSString *value = x[1];
//        NSLog(@"%@=%@", key, value);
        // 解析元组
        // 宏里面的a参数, 传递需要解析出来的变量名
        // = 右边需要解析的元组
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@=%@", key, value);
    }];
}

-(void)parseArray{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MarketTool.plist" ofType:nil];
    NSArray *dictArr = [[NSArray alloc] initWithContentsOfFile:path];
    
//    NSMutableArray *arr = [NSMutableArray array];
//    [dictArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        Flag *flag = [Flag flagWithDict:x];
//        [arr addObject:flag];
//    }];
    // 高级用法
    NSArray *arr = [[dictArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [Flag flagWithDict:value];
    }] array];
    NSLog(@"%@", arr);
}

-(void)RACDelegateEvent{
    
    // 把控制器调用didReceiveMemoryWarning转换成信号
    // rac_signalForSelector:监听某对象有没有调用某方法
    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"控制器调用didReceiveMemoryWarning");
    }];
    //不需要传数据用rac_signalForSelector ,需要传数据用 RACSubject
    [[self.redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"aa按钮被点击了");
    }];
}

-(void)RACKVO{
    // 相对于原生kvo 使代码更聚合
    [_redView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        
    }];
    
    [[_redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    
    [RACObserve(_redView, frame) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

-(void)RACBtnClickEvent{
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮被点击了");
    }];
    
}

-(void)RACNotification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

-(void)RACTextField{
    [_textfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

-(void)signalConcat{
    // 组合
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted];// 告诉发送完成,才能发送下个请求
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];
    
    // f创建组合信号  按顺序去链接
    // 注意 concat ,第一个信号必须调用 sendCompleted
    RACSignal *concatSignal = [signalA concat:signalB];
    
    // 订阅组合信号
    [concatSignal subscribeNext:^(id  _Nullable x) {
        // 节能拿到A的数据, 又能拿到B的数据
        NSLog(@"%@", x);
    }];
    
    
}

-(void)signalThen{
    // 组合
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted];// 告诉发送完成,才能发送下个请求
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];
    
    // f创建组合信号  按顺序去链接
    // 注意 then ,第一个信号必须调用 sendCompleted
    RACSignal *thenSignal = [signalA then:^RACSignal * _Nonnull{
        // 返回需要组合的信号
        return signalB;
    }];
    
    // 订阅组合信号
    [thenSignal subscribeNext:^(id  _Nullable x) {
        // 节能拿到A的数据, 又能拿到B的数据
        NSLog(@"%@", x);
    }];
    
    
}

// 多个信号组合 无序
-(void)signalMerge{
    // 组合
    RACSubject *signalA = [RACSubject subject];
    
    RACSubject *signalB = [RACSubject subject];
    
    // 组合
    RACSignal *mergeSignal = [signalA merge:signalB];
    // 订阅
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        // 任意一个信号发送内容都会调用 无序
        NSLog(@"%@", x);
    }];
    
    [signalA sendNext:@"上部分"];
    [signalB sendNext:@"下部分"];
}

-(void)signalZipWith{
    // 组合
    RACSubject *signalA = [RACSubject subject];
    
    RACSubject *signalB = [RACSubject subject];
    
    // 组合 当一个界面多个请求都完成再刷新界面
    //
    RACSignal *signal = [signalA zipWith:signalB];
    // 订阅
    [signal subscribeNext:^(id  _Nullable x) {
        // 两个信号都发送完 调用, 返回一个信号元组
        // 返回的顺序跟组合的顺序有关 与发送信号的前后无关
        NSLog(@"%@", x);
    }];
    
    [signalA sendNext:@"上部分"];
    [signalB sendNext:@"下部分"];
}

-(void)signalCombineLastest{
    // 先组合 combine 再聚合 reduce
    // 组合
    RACSignal *signalA = _textfield.rac_textSignal;
    
    RACSignal *signalB = _password.rac_textSignal;
    // reduceBlock 是有参数的, 参数跟你组合的信号有关,且一一对应
    RACSignal *combineSignal = [RACSignal combineLatest:@[signalA, signalB] reduce:^id _Nullable(NSString *account, NSString *pwd){
        // 聚合的值就是组合信号的内容
        NSLog(@"%@ %@", account, pwd);
        return @(account.length && pwd.length);
    }];
    // 订阅信号
//    [combineSignal subscribeNext:^(id  _Nullable x) {
//        _btn.enabled = [x boolValue];
//    }];
    RAC(_btn,enabled) = combineSignal;
}

-(void)liftSelector{
    // 当一个界面有多次请求的时候, 需要保证全部都请求完成才搭建界面
    
    
    // 请求热销
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 请求数据
        // AFNet
        NSLog(@"请求热销数据");
        [subscriber sendNext:@"hot data"];
        
        return nil;
    }];
    // 请求最新
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // q请求数据
        NSLog(@"请求最新数据");
        [subscriber sendNext:@"new data"];
        return nil;
    }];
    // s数组存放信号
    //  当数组中的所有信号都发送数据的时候, 才会执行 sel
    // 方法的参数g必须跟数组的信号 一一对应
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
    
}
// 宏
-(void)RACHong{
    
    // 监听文本框内容
//    [_textfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        _label.text = x;
//    }];
    // 等效上面
    RAC(_label, text) = _textfield.rac_textSignal;

    // KVO
//    [[self.view rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
//
//    }];
    [RACObserve(self.view, frame) subscribeNext:^(id  _Nullable x) {
        
    }];
    
    
}

-(void)RACMulticastConnection{
    // 创建信号
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        NSLog(@"发送热门模块请求");
//        // 发送信号
//        [subscriber sendNext:@"abc"];
//
//        return nil;
//    }];
    // 订阅信号
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"订阅者一 %@", x);
//    }];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"订阅者二 %@", x);
//    }];
    
    
    
    // 用于信号被多次订阅时, 为了保证每次订阅都请求, 只请求一次, 每次订阅只要拿到数据
    // 不管订阅多少次信号, 只会请求一次
    // RACMulticastConnection必须要有信号
    // 1.创建信号
    // 2.信号转换成连接类
    // 3.订阅连接类的信号
    // 4.连接
    
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送热门模块请求");
        // 发送信号
        [subscriber sendNext:@"热门模块数据"];
        
        return nil;
    }];
    // 信号转换成连接类   保存信号作为原信号originSignal  创建自身信号:子信号 signal
//    RACMulticastConnection *connSignal = [signal publish];

    // 用 RACReplaySubject 的y好处是可以先发送信号 , 再订阅
    RACMulticastConnection *connSignal = [signal multicast:[RACReplaySubject subject]];
    
    // 订阅信号   子信号订阅  RACSubject 订阅仅仅是保存订阅者
    [connSignal.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [connSignal.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 连接   调用原信号的订阅操作
    [connSignal connect];
}

-(void)RACCommand{
    // 处理事件
    // RACCommand 不能返回空信号
    // 当命令内部数据发送完成, 一定要主动发送完成 sendCompleted
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // input 执行命令传入的参数
        // block调用 执行命令的时候调用
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"z执行命令产生的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 监听事件有么有完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) { //当前正在执行
            NSLog(@"当前正在执行");
        } else {
            // 没有执行/执行完成
            NSLog(@"没有执行/执行完成");
        }
    }];
    
    // 2.执行命令
    RACSignal *signal = [command execute:@1];
    // 订阅命令内部的信号
    // 1. 方式一:直接订阅命令执行时返回的信号
    // 2. 方式二: RACCommand 的信号源 executionSignals 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [self RACCommandExecutionSignals];
    
    [self RACSwitchToLatest];
}

-(void)RACCommandExecutionSignals{
    // 处理事件
    // RACCommand 不能返回空信号
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // input 执行命令传入的参数
        // block调用 执行命令的时候调用
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"z执行命令产生的数据"];
            return nil;
        }];
    }];
    // 2. 方式二: RACCommand 的信号源 executionSignals 订阅信号
    // 必须要在执行命令之前订阅
//    [command.executionSignals subscribeNext:^(RACSignal *x) {
//        NSLog(@"%@", x);
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@", x);
//        }];
//    }];
    // 等效上面
    // switchToLatest获取最新发送的信号, 只能用于信号中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 2.执行命令
    [command execute:@1];
    // 订阅命令内部的信号
    
}

-(void)RACSwitchToLatest{
    // 创建信号
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    // 订阅信号
//    [signalOfSignal subscribeNext:^(RACSignal  *x) {
//        NSLog(@"%@", x);
//        [x subscribeNext:^(id  _Nullable x) {
//            // 信号中的z信号
//            NSLog(@"%@", x);
//        }];
//    }];
    // 拿到信号中的信号  switchToLatest
    [signalOfSignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 发送信号
    [signalOfSignal sendNext:signal];
    [signal sendNext:@"123D"];
    
}

-(void)RACBind{
    
    //hook 思维
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.绑定信号
    RACSignal *signal = [subject bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal *(id value, BOOL *stop){
            // 原信号subject发送消息 ,就会调用block
            // block 处理y原信号, 在返回结果之前
            //value 原信号发送的内容
            NSLog(@"接收到原信号的内容%@", value);
            // 返回信号, 不能传nil, 返回空信号
//            return [RACSignal empty];
            value = [NSString stringWithFormat:@"处理信号value:%@", value];
            return [RACReturnSignal return:value];
        };
    }];
    // 3.订阅绑定信号
    [signal subscribeNext:^(id  _Nullable x) {
        //
        NSLog(@"接收到绑定信号处理完的信号%@", x);
    }];
    
    // 4.发送信号
    [subject sendNext:@"134"];
}

// 映射
-(void)RACFlattenMap{
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    // 绑定信号
    RACSignal *bindSignal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        // value: 原信号发送内容
        NSLog(@"%@", value);
        value = [NSString stringWithFormat:@"映射信息%@", value];
        // 返回信号用来包装成修改内容
        return [RACReturnSignal return:value];
    }];
    // 订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 原信号发送消息
    [subject sendNext:@"原信号"];
    
    
    // y信号中的信号
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
//    [signalOfSignal subscribeNext:^(RACSignal *x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@",x);
//        }];
//    }];
    
//    RACSignal *bindSignalOfSignal = [signalOfSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        return value;
//    }];
//    [bindSignalOfSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    [[signalOfSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [signalOfSignal sendNext:signal];
    [signal sendNext:@"1234ff"];
}

-(void)RACMap{
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    RACSignal *bindSignal = [subject map:^id _Nullable(id  _Nullable value) {
        // 返回的类型就是 需要映射的值
        return [NSString stringWithFormat:@"映射%@", value];
    }];
    //订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [subject sendNext:@"1234"];
}

-(void)RACFilter{
    // 只有当我们文本框的内容长度大于5, 才要获取文本框的内容
    RACSignal *signal = [_textfield.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        // 只有满足条件,才能获取到d内容
        return value.length > 5;
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
}

-(void)RACIgnore{
    RACSubject *subject = [RACSubject subject];
    
    RACSignal *ignoreSignal = [subject ignore:@"1"]; // [subject ignoreValues]; //忽略所有的值
    [ignoreSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"12"];
    [subject sendNext:@"142"];
}

-(void)RACTake{
    RACSubject *subject = [RACSubject subject];
    // 取几个值
    [[subject take:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];

    // takeLast: 取后面几个值, 必须要发送完成sendCompleted
    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // takeUntil 只要传入信号发送完成或者发送任意数据, 就不会再接收源信号的内容
    RACSubject *signal = [RACSubject subject];
    [[subject takeUntil:signal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"12"];
    [signal sendNext:@"23"];
//    [signal sendCompleted];
    [subject sendNext:@"142"];
    [subject sendCompleted];
}

-(void)RACDistinctUntilChanged{
    // distinctUntilChanged 如果当前的值跟上一个值相同, 就不会被订阅到
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"1"];
    [subject sendNext:@"1"];
    [subject sendNext:@"12"];
    [subject sendNext:@"1"];
    
}

-(void)RACSkip{
    // 跳跃两个值才执行
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"4"];
    [subject sendNext:@"12"];
    [subject sendNext:@"3"];
}

-(void)updateUIWithHotData:(NSString *)hotData newData:(NSString *)newData{
    // 拿到请求数据
    NSLog(@"更新UI %@  %@", hotData, newData);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)didReceiveMemoryWarning{
    
}

@end

/**
 *
 信号类
 RACSignal
 RACSubject
 RACReplaySubject
 
 不同的信号订阅方式不同
 RACDynamicSignal :1.创建订阅者RACSubscriber  2.执行didSubscribe
 RACSubject  1.创建订阅者  2.保存订阅者
 RACReplaySubject  1.创建订阅者     2.拿到w当前创建订阅者, 发送保存的所有的值
 
 
 
 
 
 
 
 
 
 */
