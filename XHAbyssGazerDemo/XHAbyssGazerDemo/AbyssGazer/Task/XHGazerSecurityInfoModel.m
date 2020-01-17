//
//  XHGazerSecurityInfoModel.m
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import "XHGazerSecurityInfoModel.h"

@interface XHGazerSecurityInfoModel ()

@property (nonatomic, strong) NSString *serialName;
@property (nonatomic, strong) NSString *commonName;
@property (nonatomic, strong) NSString *subjectName;

@end

@implementation XHGazerSecurityInfoModel

- (instancetype)initWithSerialName:(NSString *)serialName
                        commonName:(NSString *)commonName
                       subjectName:(NSString *)subjectName {
    self = [super init];
    if (self) {
        self.serialName = serialName;
        self.commonName = commonName;
        self.subjectName = subjectName;
    }
    
    return self;
}

@end
