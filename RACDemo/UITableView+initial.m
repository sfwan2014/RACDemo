//
//  UITableView+initial.m
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "UITableView+initial.h"

@implementation UITableView (initial)
+(id)dbc_makeUITableViewInitial:(void(^)(DBCTableViewManager *make))block{
    DBCTableViewManager *make = [[DBCTableViewManager alloc] init];
    block(make);
    return make.tableView;
}
@end
