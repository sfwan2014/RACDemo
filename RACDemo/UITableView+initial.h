//
//  UITableView+initial.h
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCTableViewManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (initial)
+(id)dbc_makeUITableViewInitial:(void(^)(DBCTableViewManager *make))block;
@end

NS_ASSUME_NONNULL_END
