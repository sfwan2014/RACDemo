//
//  NSObject+Caculater.m
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "NSObject+Caculater.h"

@implementation NSObject (Caculater)
-(int)dbc_makeCaculater:(void(^)(CaculaterManager *make))block{
    CaculaterManager *mg = [[CaculaterManager alloc] init];
    block(mg);
    return mg.result;
}
@end
