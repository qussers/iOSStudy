//
//  LZYShareTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/1.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZYShareModel,LZYShareTableViewCell;


@protocol LZYShareTableViewCellDelegate <NSObject>

//点击用户
- (void)cellDidClickUser:(LZYShareTableViewCell *)cell;

//点击评论
- (void)cellDidClickComment:(LZYShareTableViewCell *)cell;

//点击赏
- (void)cellDidClickReword:(LZYShareTableViewCell *)cell;

@end


@interface LZYShareTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *userIconBtn;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *urlImageView;

@property (weak, nonatomic) IBOutlet UILabel *urlDescribeLabel;

@property (nonatomic, weak) id<LZYShareTableViewCellDelegate> delegate;


+ (void)configeCellHeightWithModel:(LZYShareModel *)model;

- (void)configeCellWithModel:(LZYShareModel *)model;

@end
