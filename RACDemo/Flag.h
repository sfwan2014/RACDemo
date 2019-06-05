//
//  Flag.h
//  RACDemo
//
//  Created by DBC on 2018/12/12.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Flag : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;

+(instancetype)flagWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
