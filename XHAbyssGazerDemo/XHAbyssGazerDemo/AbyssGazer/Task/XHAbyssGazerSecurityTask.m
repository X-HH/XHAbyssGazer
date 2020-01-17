//
//  XHAbyssGazerSecurityTask.m
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import "XHAbyssGazerSecurityTask.h"
#import "XHGazerSecurityInfoModel.h"
#import "XHAbyssGazerUtils.h"

@interface XHAbyssGazerSecurityTask ()

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) NSArray *hostList;
@property (nonatomic, strong) NSMutableSet *validDatas;
@property (nonatomic, strong) NSMutableSet *netDatas;
@property (nonatomic, strong) NSMutableSet *dataInfo;
@property (nonatomic, strong) NSMutableSet *pathInfo;


@end

@implementation XHAbyssGazerSecurityTask

+ (instancetype)sharedInstance {
    static XHAbyssGazerSecurityTask *_securityTask;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _securityTask = [[XHAbyssGazerSecurityTask alloc] init];
    });
    return _securityTask;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.validDatas = [[NSMutableSet alloc] init];
    self.netDatas = [[NSMutableSet alloc] init];
    self.dataInfo = [[NSMutableSet alloc] init];
    self.pathInfo = [[NSMutableSet alloc] init];
    //host名单列表
    self.hostList = @[@""];
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 1;
    return self;
}

- (void)listenWithProtectionSpace:(NSURLProtectionSpace *)space {
    [self listenWithSessionTask:nil protectionSpace:space];
}

- (void)listenWithSessionTask:(NSURLSessionTask * _Nullable)task protectionSpace:(NSURLProtectionSpace *)space {
    [self.queue addOperationWithBlock:^{
        if (![self needListenWithHost:space.host]) {
            return;
        }
        SecTrustRef serverTrust = space.serverTrust;
        [self appendSecTrustRef:serverTrust];
        if (self.validDatas.count > 0) {
            [self compareDataWithTask:task];
        }
    }];
}

- (void)appendSecTrustRef:(SecTrustRef)serverTrust {
    CFIndex certificateCount = SecTrustGetCertificateCount(serverTrust);

    for (CFIndex i = 0; i < certificateCount; i++) {
        SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, i);
        [self.netDatas addObject:(__bridge_transfer NSData *)SecCertificateCopyData(certificate)];
        
        //处理数据
        XHGazerSecurityInfoModel *model = [[XHGazerSecurityInfoModel alloc] initWithSerialName:[XHAbyssGazerUtils seRialName:certificate] commonName:[XHAbyssGazerUtils coMmonName:certificate] subjectName:[XHAbyssGazerUtils suBjectName:certificate]];
        [self.dataInfo addObject:model];
    }
}

- (void)compareDataWithTask:(NSURLSessionTask *)task {
    BOOL pass = NO;
    NSString *path = @"localDelegate";
    for (NSData *netData in self.netDatas) {
        for (NSData *validData in self.validDatas) {
            if (validData == netData) {
                pass = YES;
                break;
            }
        }
        if (pass) {
            break;
        }
    }
    if (!pass) {
        path = task.currentRequest.URL.path;
        [self.pathInfo addObject:path];
        //TODO：自定义处理部分
    }
}


- (BOOL)needListenWithHost:(NSString *)host {
    BOOL needListen = NO;
    for (NSString *whiteHost in self.hostList) {
        if ([whiteHost isEqualToString:host]) {
            needListen = YES;
            break;
        }
    }
    return needListen;
}


- (void)executeTask {
    //TODO：自定义处理部分，常驻线程定时任务
}


@end
