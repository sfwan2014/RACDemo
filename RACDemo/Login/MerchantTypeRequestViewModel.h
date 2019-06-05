//
//  MerchantTypeRequestViewModel.h
//  RACDemo
//
//  Created by DBC on 2018/12/15.
//  Copyright © 2018 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
NS_ASSUME_NONNULL_BEGIN

@interface MerchantTypeRequestViewModel : NSObject
@property (nonatomic, strong, readonly) RACCommand *requestcCommand;
@end

NS_ASSUME_NONNULL_END
