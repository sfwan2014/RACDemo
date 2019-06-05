//
//  DBCTableViewManager.h
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBCTableViewManager : NSObject
@property (nonatomic, strong) UITableView *tableView;

-(DBCTableViewManager * (^)(NSString *))name;
-(DBCTableViewManager * (^)(id))delegate;
-(DBCTableViewManager * (^)(NSString *))cellIdentify;
-(DBCTableViewManager * (^)(NSString *))registerCellClassName;
-(DBCTableViewManager * (^)(UINib *))registerCellNib;
@end

NS_ASSUME_NONNULL_END
