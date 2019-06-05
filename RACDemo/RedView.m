//
//  RedView.m
//  RACDemo
//
//  Created by DBC on 2018/12/12.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (RACSubject *)btnClockSignal{
    if (_btnClockSignal == nil) {
        _btnClockSignal = [RACSubject subject];
    }
    return _btnClockSignal;
}

- (IBAction)btnClick:(id)sender {
    NSLog(@"按钮点击");
    [self.btnClockSignal sendNext:@"按钮被点击1"];
}

@end
