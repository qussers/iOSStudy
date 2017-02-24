//
//  UIImage+LZYAdd.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LZYAdd)

//高斯模糊
- (UIImage *)blurImageWithRadius:(CGFloat)radius;
- (UIImage *)blurryImageWithLevel:(CGFloat)blur;
@end
