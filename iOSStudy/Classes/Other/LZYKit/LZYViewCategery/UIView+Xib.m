//
//  UIView+Xib.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "UIView+Xib.h"

@implementation UIView (Xib)

+ (UIView *)loadViewWithXibName:(NSString *)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] lastObject];
}

@end
