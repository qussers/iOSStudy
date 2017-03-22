//
//  UIButton+LZYAdd.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/7.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "UIButton+LZYWebCache.h"
#import <YYKit.h>
@implementation UIButton (LZYWebCache)

- (void)lzy_setImageWithURL:(NSString *)url
{
    [self setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholder:nil];
}

@end
