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


- (NSArray *)filterImage
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [self substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}


- (NSMutableArray *)parseToWebLink
{
    NSString *startString = @"<herf>";
    NSString *endString = @"</herf>";
    if (!([self containsString:startString] && [self containsString:endString])) {
        return nil;
    }
    NSMutableArray *result = @[].mutableCopy;
    NSString *desString = [self mutableCopy];
    do{
        NSInteger index = 0;
        if (result.count > 0) {
            NSValue *lastValue = [result lastObject];
            NSRange lastRange = [lastValue rangeValue];
            index = lastRange.location;
        }
        NSRange startRange = [desString rangeOfString:startString];
        NSRange endRange = [desString rangeOfString:endString];
        NSInteger newLocation = startRange.location + startRange.length;
        NSInteger newLength = endRange.location - newLocation;
        NSRange newRange = NSMakeRange(newLocation + index, newLength);
        NSValue *value = [NSValue valueWithRange:newRange];
        [result addObject:value];
        desString = [desString substringFromIndex:(endRange.length+endRange.location)];
    }while ([desString containsString:startString] && [desString containsString:endString]);
    
    
    return result;
}


//生成唯一的字符串
+ (NSString *)createUUID
{
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uniqueId = (__bridge NSString *)uuidStringRef;
    return uniqueId;
}

@end
