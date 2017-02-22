//
//  LZYDynamicTitlesView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZYDynamicTitlesView;



@interface LZYDynamicSubTitleView : UIView

//标题
@property (nonatomic, copy) NSString *title;

//点击回调事件
@property (nonatomic, copy) void(^dynamicSubTitleDidClick)(LZYDynamicSubTitleView *subTitleView);

//有新消息时显示红点
- (void)hasNewNotification;

//阅读完毕，移除红点
- (void)removeNotification;

@end



@protocol LZYDynamicTitlesViewDelegate <NSObject>


//点击了对应标题
- (void)dynamicTitleView:(LZYDynamicTitlesView *)dynamicTitleView didSelected:(NSInteger)index;

@end

@interface LZYDynamicTitlesView : UIView

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) id<LZYDynamicTitlesViewDelegate> delegate;


- (void)hasNewNotificationViewIndex:(NSInteger)index;

- (void)removeNotificationWithIndex:(NSInteger)index;


@end
