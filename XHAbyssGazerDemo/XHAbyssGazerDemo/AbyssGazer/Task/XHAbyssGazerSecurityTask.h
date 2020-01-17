//
//  XHAbyssGazerSecurityTask.h
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHAbyssGazerTaskProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface XHAbyssGazerSecurityTask : NSObject<XHAbyssGazerTaskProtocol>

+ (instancetype)sharedInstance;

- (void)listenWithProtectionSpace:(NSURLProtectionSpace *)space;

- (void)listenWithSessionTask:(NSURLSessionTask * _Nullable)task protectionSpace:(NSURLProtectionSpace *)space;

@end

NS_ASSUME_NONNULL_END
