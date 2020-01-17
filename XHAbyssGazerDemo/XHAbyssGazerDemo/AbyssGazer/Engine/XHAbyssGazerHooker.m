//
//  XHAbyssGazerHooker.m
//  XiaoLanBen
//
//  Created by xhh on 2020/1/9.
//  Copyright © 2020 U51. All rights reserved.
//

#import "XHAbyssGazerHooker.h"
#import <RSSwizzle/RSSwizzle.h>
#import "XHAbyssGazerSecurityTask.h"

@implementation XHAbyssGazerHooker

+ (void)load {
    RSSwizzleClassMethod([NSURLSession class], @selector(sessionWithConfiguration:delegate:delegateQueue:), RSSWReturnType(NSURLSession*), RSSWArguments(NSURLSessionConfiguration *configuration, id <NSURLSessionDelegate>delegate, NSOperationQueue *queue), RSSWReplacement({
        NSLog(@"Class testClassMethod2 Swizzle");
        
        if (delegate != nil) {
            if ([delegate respondsToSelector:@selector(URLSession:task:didReceiveChallenge:completionHandler:)]) {
                [XHAbyssGazerHooker xh_swizzleTaskReceive:delegate];
            }
            if ([delegate respondsToSelector:@selector(URLSession:didReceiveChallenge:completionHandler:)]) {
                [XHAbyssGazerHooker xh_swizzleReceive:delegate];
            }
        }
        
        return RSSWCallOriginal(configuration, delegate, queue);
        
    }));
}

+ (void)xh_swizzleTaskReceive:(id <NSURLSessionDelegate>)delegate {
    RSSwizzleInstanceMethod([delegate class], @selector(URLSession:task:didReceiveChallenge:completionHandler:), RSSWReturnType(void), RSSWArguments(NSURLSession *session, NSURLSessionTask *task, NSURLAuthenticationChallenge *challenge, void (^completionHandler)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential)), RSSWReplacement({
        RSSWCallOriginal(session, task, challenge, completionHandler);
        
        [[XHAbyssGazerSecurityTask sharedInstance] listenWithSessionTask:task protectionSpace:challenge.protectionSpace];
    }), 0, NULL);
}

+ (void)xh_swizzleReceive:(id <NSURLSessionDelegate>)delegate {
    RSSwizzleInstanceMethod([delegate class], @selector(URLSession:didReceiveChallenge:completionHandler:), RSSWReturnType(void), RSSWArguments(NSURLSession *session, NSURLAuthenticationChallenge *challenge, void (^completionHandler)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential)), RSSWReplacement({
           RSSWCallOriginal(session, challenge, completionHandler);
        [[XHAbyssGazerSecurityTask sharedInstance] listenWithProtectionSpace:challenge.protectionSpace];
       }), 0, NULL);
}

@end
