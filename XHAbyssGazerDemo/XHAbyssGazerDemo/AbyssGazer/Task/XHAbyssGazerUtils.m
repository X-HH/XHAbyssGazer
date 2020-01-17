//
//  XHAbyssGazerUtils.m
//  XiaoLanBen
//
//  Created by xhh on 2020/1/15.
//  Copyright © 2020 U51. All rights reserved.
//

#import "XHAbyssGazerUtils.h"

@implementation XHAbyssGazerUtils

+ (NSString *)seRialName:(SecCertificateRef)secTruct {
    CFDataRef serialName = NULL;
    
    if (@available(iOS 11.0, *)) {
        serialName = SecCertificateCopySerialNumberData(secTruct, nil);
    } else {
        if (@available(iOS 10.3, *)) {
            serialName = SecCertificateCopySerialNumber(secTruct);
        } else {
            // Fallback on earlier versions
        }
    }
    
    if (serialName != NULL) {
        NSData *serialData = CFBridgingRelease(serialName);
        NSString *name = [self _convertDataToHexStr:serialData];
        return name;
    }
    
    return @"";
}

+ (NSString *)coMmonName:(SecCertificateRef)secStruct {
    CFStringRef commonName = NULL;
    if (@available(iOS 10.3, *)) {
        SecCertificateCopyCommonName(secStruct, &commonName);
        if (commonName != NULL) {
            NSString *name = CFBridgingRelease(commonName);
            return name;
        }
    } else {
        // Fallback on earlier versions
    }
    
    return @"";
}

+ (NSString *)suBjectName:(SecCertificateRef)secStruct {
    CFStringRef subjectName = SecCertificateCopySubjectSummary(secStruct);
    
    if (subjectName != NULL) {
        NSString *name = CFBridgingRelease(subjectName);
        return name;
    }
    
    return @"";
}

+ (NSString *)_convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+ (char *)libNameWithPath:(char *)libNamePath {
    NSString *libNamePathStr = [NSString stringWithCString:libNamePath encoding:NSUTF8StringEncoding];
    NSString *libNameStr = [libNamePathStr componentsSeparatedByString:@"/"].lastObject;
    return [libNameStr cStringUsingEncoding:NSUTF8StringEncoding];
}

@end
