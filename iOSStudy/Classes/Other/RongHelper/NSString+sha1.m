//
//  NSString+sha1.m
//  验证码绘制
//
//  Created by 李志宇 on 15/11/7.
//  Copyright © 2015年 99所. All rights reserved.
//

#import "NSString+sha1.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (sha1)


- (NSString *)sha1
{
    //  将字符串转换成 C字符串
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    //  C字符串转换成二进制数据
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (uint32_t)data.length, digest);
    NSMutableString *encryptionString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [encryptionString appendFormat:@"%02x", digest[i]];
    }
    
    return encryptionString;
}
@end
