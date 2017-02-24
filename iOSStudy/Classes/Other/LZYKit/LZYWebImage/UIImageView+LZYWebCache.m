//
//  UIImageView+LZYWebCache.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "UIImageView+LZYWebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation UIImageView (LZYWebCache)

- (void)lzy_setImageWithURL:(NSString *)url
{
    NSURL *rUrl = [NSURL URLWithString:url];
    [self sd_setImageWithURL:rUrl placeholderImage:nil];
}

@end
