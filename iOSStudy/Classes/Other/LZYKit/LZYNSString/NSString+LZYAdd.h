//
//  UIViewController+LZYAdd.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (LZYAdd)

- (NSString *)stringByTrim;

//根据文本计算所占区域
- (CGSize)stringWithMaxSize:(CGSize)maxSize  fontSize:(CGFloat)fontSize;
@end
