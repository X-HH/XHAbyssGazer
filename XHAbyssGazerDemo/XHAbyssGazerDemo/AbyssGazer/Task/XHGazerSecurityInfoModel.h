//
//  XHGazerSecurityInfoModel.h
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHGazerSecurityInfoModel : NSObject

- (instancetype)initWithSerialName:(NSString *)serialName
                        commonName:(NSString *)commonName
                       subjectName:(NSString *)subjectName;

@end

NS_ASSUME_NONNULL_END
