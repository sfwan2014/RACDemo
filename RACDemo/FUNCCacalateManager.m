//
//  FUNCCacalateManager.m
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "FUNCCacalateManager.h"

@implementation FUNCCacalateManager
-(instancetype)caculate:(int (^)(int))caculateBlock{
    _result = caculateBlock(_result);
    return self;
}
@end
