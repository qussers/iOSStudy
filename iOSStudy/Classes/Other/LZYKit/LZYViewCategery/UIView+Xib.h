//
//  UIView+Xib.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Xib)

+ (UIView *)loadViewWithXibName:(NSString *)name;
@end