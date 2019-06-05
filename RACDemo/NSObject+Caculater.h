//
//  NSObject+Caculater.h
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculaterManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Caculater)
-(int)dbc_makeCaculater:(void(^)(CaculaterManager *make))block;
@end

NS_ASSUME_NONNULL_END
