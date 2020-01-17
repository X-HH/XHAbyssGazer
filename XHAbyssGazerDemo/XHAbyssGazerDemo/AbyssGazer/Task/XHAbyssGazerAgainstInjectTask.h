//
//  XHAbyssGazerAgainstInjectTask.h
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHAbyssGazerTaskProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface XHAbyssGazerAgainstInjectTask : NSObject<XHAbyssGazerTaskProtocol>

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
