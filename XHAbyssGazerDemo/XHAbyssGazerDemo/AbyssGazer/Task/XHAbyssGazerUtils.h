//
//  XHAbyssGazerUtils.h
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHAbyssGazerUtils : NSObject

+ (NSString *)seRialName:(SecCertificateRef)secTruct;

+ (NSString *)coMmonName:(SecCertificateRef)secStruct;

+ (NSString *)suBjectName:(SecCertificateRef)secStruct;

+ (char *)libNameWithPath:(char *)libNamePath;

@end

NS_ASSUME_NONNULL_END
