//
//  DBCTableViewManager.m
//  RACDemo
//
//  Created by DBC on 2018/12/11.
//  Copyright © 2018 DBC. All rights reserved.
//

#import "DBCTableViewManager.h"

@interface DBCTableViewManager ()
@property (nonatomic, strong) NSString *tableClassName;
@property (nonatomic, strong) NSString *cellIdent;
@end

@implementation DBCTableViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)_configTableView{
    if (self.tableClassName.length == 0) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        return;
    }
    Class class = NSClassFromString(self.tableClassName);
    if (class == NULL) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        return;
    }
    
    self.tableView = [[class alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

-(DBCTableViewManager * (^)(NSString *))name{
    return ^(NSString *name){
        self.tableClassName = name;
        if (self.tableView == nil) {
            [self _configTableView];
        }
        return self;
    };
}

-(DBCTableViewManager * (^)(id))delegate{
    return ^(id delegate){
        self.tableView.delegate = delegate;
        self.tableView.dataSource = delegate;
        return self;
    };
}

-(DBCTableViewManager * (^)(NSString *))cellIdentify{
    return ^(NSString *cellIdentify){
        self.cellIdent = cellIdentify;
        return self;
    };
}

-(DBCTableViewManager * (^)(NSString *))registerCellClassName{
    return ^(NSString *cellClassName){
        [self.tableView registerClass:NSClassFromString(cellClassName) forCellReuseIdentifier:self.cellIdent];
        return self;
    };
}

-(DBCTableViewManager * (^)(UINib *))registerCellNib{
    return ^(UINib *cellNib){
        [self.tableView registerNib:cellNib forCellReuseIdentifier:self.cellIdent];
        return self;
    };
}

@end
