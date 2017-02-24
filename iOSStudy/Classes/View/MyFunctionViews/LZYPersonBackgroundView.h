//
//  LZYPersonView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/18.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZYPersonBackgroundViewDelegate <NSObject>

//用户头像点击事件
- (void)iconViewClick;


@end

@interface LZYPersonBackgroundView : UIView

@property (nonatomic, weak) id<LZYPersonBackgroundViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end
