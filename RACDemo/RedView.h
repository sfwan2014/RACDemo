//
//  RedView.h
//  RACDemo
//
//  Created by DBC on 2018/12/12.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
NS_ASSUME_NONNULL_BEGIN

@interface RedView : UIView
@property (nonatomic, strong) RACSubject *btnClockSignal;
@end

NS_ASSUME_NONNULL_END
