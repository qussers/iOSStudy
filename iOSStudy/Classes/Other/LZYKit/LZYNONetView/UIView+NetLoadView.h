//
//  UIView+newLoadView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYNetLoadView.h"
@interface UIView (NetLoadView)

@property (nonatomic, strong) LZYNetLoadView *loadView;

- (void)beginLoading;
- (void)endLoading;
- (void)loadError;
- (void)loadNone;

@end
