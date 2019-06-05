//
//  FUNCCacalateManager.h
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FUNCCacalateManager : NSObject

@property (nonatomic, assign) int result;

-(instancetype)caculate:(int(^)(int))caculateBlock;
@end

NS_ASSUME_NONNULL_END
