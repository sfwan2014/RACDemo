//
//  CaculaterManager.h
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaculaterManager : NSObject
@property (nonatomic, assign) int result;

-(CaculaterManager* (^)(int))add;
@end

NS_ASSUME_NONNULL_END
