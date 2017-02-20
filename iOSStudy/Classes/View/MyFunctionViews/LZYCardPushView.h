//
//  LZYCardPushView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/19.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZYCardPushView;

@protocol LZYCardPushViewDataSource <NSObject>

//有多少张卡片
- (NSInteger)numberOfCardsWithPushView:(  LZYCardPushView * _Nullable )cardPushView;

//索引值下返回的视图
- (UIView * __nullable)cardPushView:(LZYCardPushView * __nullable)cardPushView index:(NSInteger)pageIndex;

@end

@interface LZYCardPushView : UIView

@property (nonatomic, weak) IBOutlet __nullable id<LZYCardPushViewDataSource> dataSource;

@end
