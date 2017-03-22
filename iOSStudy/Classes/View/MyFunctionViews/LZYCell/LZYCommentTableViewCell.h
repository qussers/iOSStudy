//
//  LZYCommentTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/28.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYKit.h>

@class LZYCommentTableViewCell;
@class LZYCommentLayoutModel;
@protocol LZYCommentTableViewCellDelegate <NSObject>

//点击了用户头像
- (void)cellDidClickUserIcon:(LZYCommentTableViewCell *)cell;


//点击了赞、赏
- (void)cellDidClickReword:(LZYCommentTableViewCell *)cell;


//点击了网页链接
- (void)cell:(LZYCommentTableViewCell *)cell didClickWebUrl:(NSString *)url;


//点击了图片链接
- (void)cell:(LZYCommentTableViewCell *)cell didClickImageWithIndex:(NSInteger)index;

@end


@interface LZYCommentTableViewCell : UITableViewCell


@property (nonatomic, strong) UIView *topLine;

//用户头像图标
@property (nonatomic, strong) UIButton *iconBtn;

//用户名称
@property (nonatomic, strong) YYLabel *userNameLabel;

//时间
@property (nonatomic, strong) YYLabel *timeLabel;

//回复
@property (nonatomic, strong) YYLabel *answerLabel;

//内容
@property (nonatomic, strong) YYLabel *contentLabel;

//图片容器
@property (nonatomic, strong) UIScrollView *imagesScrollView;

//图片
@property (nonatomic, strong) NSMutableArray *images;

//赏
@property (nonatomic, strong) UIButton *rewardBtn;

//代理
@property (nonatomic, weak) id<LZYCommentTableViewCellDelegate> delegate;


- (void)configeCellWithLayoutModel:(LZYCommentLayoutModel *)layout;

@end
