//
//  LZYBaseHelpTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZYBaseHelpTableViewCell;

@protocol LZYHelpTableViewCellDelegate <NSObject>

//点击了用户中心
- (void)cellDidClickUser:(LZYBaseHelpTableViewCell *)cell;

//点击“帮助他”
- (void)cellDidClickHelp:(LZYBaseHelpTableViewCell *)cell;

//点击了图片
- (void)cell:(LZYBaseHelpTableViewCell *)cell didClickImageWithIndex:(NSInteger)index;

@end

@interface LZYBaseHelpTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *tooBarView;

@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNaleLabel;

@property (weak, nonatomic) IBOutlet UILabel *helpCommentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *helpCommentImageView;

@property (weak, nonatomic) IBOutlet UIView *imageViewsContaonerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tooBarYCons;

@property (nonatomic, weak) id<LZYHelpTableViewCellDelegate> delegate;

+ (void)addHeightToCellModel:(NSArray *)models;

@end
