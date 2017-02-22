//
//  LZYWaveView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JSWaveBlock)(CGFloat currentY);

@interface LZYWaveView : UIView

//浪弯曲度
@property (nonatomic, assign) CGFloat waveCurvature;

//浪速
@property (nonatomic, assign) CGFloat waveSpeed;

//浪高
@property (nonatomic, assign) CGFloat waveHeight;

//实浪颜色
@property (nonatomic, strong) UIColor *waveColor;


@property (nonatomic, copy) JSWaveBlock waveBlock;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
