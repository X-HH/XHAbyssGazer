//
//  XHAbyssGazerAgainstInjectTask.m
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import "XHAbyssGazerAgainstInjectTask.h"
#import <mach-o/dyld.h>
#import <string.h>
#import <stdio.h>
#import <stdlib.h>
#import <sys/types.h>
#import <CommonCrypto/CommonDigest.h>
#import "XHAbyssGazerUtils.h"

@interface XHAbyssGazerAgainstInjectTask ()

@property (nonatomic, strong) NSMutableArray *dyldList;

@end

char *chars[1024];

@implementation XHAbyssGazerAgainstInjectTask

+ (instancetype)sharedInstance {
    static XHAbyssGazerAgainstInjectTask *_injectTask;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _injectTask = [[XHAbyssGazerAgainstInjectTask alloc] init];
    });
    return _injectTask;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.dyldList = [[NSMutableArray alloc] init];
    [self getWhiteDyldLis];
    return self;
}

- (void)executeTask {
    checkInjector();
}

int checkInjector() {
    int count = _dyld_image_count();
    if (count > 0) {
        for (unsigned i = 0; i < count; i++) {
            int inject = 1;
            char *imgName = _dyld_get_image_name(i);
            imgName = [XHAbyssGazerUtils libNameWithPath:imgName];
            NSString *imgNameStr = [NSString stringWithCString:imgName encoding:NSUTF8StringEncoding];
            for (unsigned j = 0; j < 1024; j++) {
                char *whiteName = chars[j];
                if (whiteName != NULL) {
                    if (strlen(whiteName) != 0) {
                        NSString *whiteNameStr = [NSString stringWithCString:whiteName encoding:NSUTF8StringEncoding];
                        if ([imgNameStr isEqualToString:whiteNameStr]) {
                            inject = 0;
                            break;
                        }
                    } else {
                        inject = 0;
                    }
                } else {
                    inject = 0;
                }
            }
            if (inject == 1) {
                //TODO：自定义处理部分
                
            }
        }
    }
    return 0;
}

- (void)getWhiteDyldLis {
    int count = _dyld_image_count();
    if (count > 0) {
        for (unsigned i = 0; i < count; i++) {
            char *imgName = _dyld_get_image_name(i);
            chars[i] = [XHAbyssGazerUtils libNameWithPath:imgName];
        }
    }
    
//    for (unsigned i = 0; i < 1024; i++){
//        char *ps = chars[i];
//        if (ps != NULL) {
//            if (strlen(ps) != 0) {
//                NSString *imgNameStr = [NSString stringWithCString:ps encoding:NSUTF8StringEncoding];
//                NSLog(@"%@", imgNameStr);
//            } else {
//            }
//        }
//    }
}

@end
