//
//  CaculaterManager.m
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "CaculaterManager.h"

@implementation CaculaterManager{
    
}
-(CaculaterManager* (^)(int))add{
    return ^(int value) {
        _result += value;
        return self;
    };
}
@end
