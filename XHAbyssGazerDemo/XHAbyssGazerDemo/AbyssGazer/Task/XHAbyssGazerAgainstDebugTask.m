//
//  XHAbyssGazerAgainstDebugTask.m
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import "XHAbyssGazerAgainstDebugTask.h"
#import <dlfcn.h>
#import <sys/sysctl.h>
#import <mach/task.h>
#import <mach/mach_init.h>
#include <termios.h>
#include <sys/ioctl.h>
@implementation XHAbyssGazerAgainstDebugTask

+ (void)executeAgainstDebugTask {
    if (isDebuggerPresent()) {
        //TODO：自定义处理部分
       
    }
}


BOOL isDebuggerPresent(){
    int name[4];                //指定查询信息的数组
    
    struct kinfo_proc info;     //查询的返回结果
    size_t info_size = sizeof(info);
    
    info.kp_proc.p_flag = 0;
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    
    if(sysctl(name, 4, &info, &info_size, NULL, 0) == -1){
        NSLog(@"sysctl error : %s", strerror(errno));
        return NO;
    }
    
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

@end
