//
//  Flag.m
//  RACDemo
//
//  Created by DBC on 2018/12/12.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "Flag.h"

@implementation Flag
+(instancetype)flagWithDict:(NSDictionary *)dict{
    Flag *flag = [[self alloc] init];
    
    [flag setValuesForKeysWithDictionary:dict];
    return flag;
}
@end
