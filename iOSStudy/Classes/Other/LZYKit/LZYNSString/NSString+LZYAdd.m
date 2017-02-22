//
//  UIViewController+LZYAdd.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "NSString+LZYAdd.h"

@implementation NSString (LZYAdd)
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (CGSize)stringWithMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [attrs setObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size =  [self boundingRectWithSize:CGSizeMake( maxSize.width,maxSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

@end
