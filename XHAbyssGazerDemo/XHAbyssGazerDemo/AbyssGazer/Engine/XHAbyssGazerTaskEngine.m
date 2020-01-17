//
//  XHAbyssGazerTaskEngine.m
//  XiaoLanBen
//
//  Created by xhh on 2020/1/9.
//  Copyright © 2020 U51. All rights reserved.
//

#import "XHAbyssGazerTaskEngine.h"
#import "XHAbyssGazerSecurityTask.h"
#import "XHAbyssGazerAgainstDebugTask.h"
#import "XHAbyssGazerAgainstInjectTask.h"


@interface XHAbyssGazerTaskEngine ()

@property (nonatomic, strong) NSThread *gazerThread;
@property (nonatomic, strong) NSMutableArray *taskArray;

@end

@implementation XHAbyssGazerTaskEngine

+ (void)load {
    [XHAbyssGazerTaskEngine sharedInstance];
}

+ (instancetype)sharedInstance {
    static XHAbyssGazerTaskEngine *engine;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[XHAbyssGazerTaskEngine alloc] init];
    });
    return engine;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.taskArray = [[NSMutableArray alloc] initWithCapacity:5];
    [self.taskArray addObject:XHAbyssGazerSecurityTask.sharedInstance];
    [self.taskArray addObject:XHAbyssGazerAgainstInjectTask.sharedInstance];
    
    [self startThread];
    
    return self;
}

- (void)startThread {
    self.gazerThread = [[NSThread alloc] initWithTarget:self selector:@selector(gazerTimer) object:nil];
    [self.gazerThread start];
}

- (void)gazerTimer {
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(disposeTask) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    timer.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:5];
    
    [[NSRunLoop currentRunLoop] run];
}

- (void)disposeTask {
    for (NSObject<XHAbyssGazerTaskProtocol> *task in self.taskArray) {
        [task executeTask];
    }
    [XHAbyssGazerAgainstDebugTask executeAgainstDebugTask];
}

@end
