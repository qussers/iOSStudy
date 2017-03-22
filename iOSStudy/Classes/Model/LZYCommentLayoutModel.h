//
//  LZYCommentLayoutModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/28.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZYCommentModel;

@class LZYCommentTableViewCell;

@interface LZYCommentLayoutModel : NSObject

//名称
@property (nonatomic, assign) CGRect iconFrame;

//
@property (nonatomic, assign) CGRect userNameLabelFrame;

//
@property (nonatomic, assign) CGRect timeLabelFrame;

//回复
@property (nonatomic, assign) CGRect answerLabelFrame;

//内容
@property (nonatomic, assign) CGRect contentLabelFrame;

//图片容器
@property (nonatomic, assign) CGRect imagesScrollViewFrame;

//赏
@property (nonatomic, assign) CGRect rewardBtnFrame;


//c
@property (nonatomic, assign) CGRect cellFrame;


@property (nonatomic, strong) LZYCommentModel *model;


- (instancetype)initWithModel:(LZYCommentModel *)model;

@end
