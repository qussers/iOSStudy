//
//  LZYInterviewTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZYInterviewModel;
@class LZYInterviewTableViewCell;


@protocol LZYInterviewCellDelegate <NSObject>





@end

@interface LZYInterviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *interviewUserImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *interviewUserName;

@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *tagsView;

@property (weak, nonatomic) IBOutlet UILabel *interviewContentLabel;


@property (weak, nonatomic) IBOutlet UIView *toolBarView;


@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *interviewHeightConstraint;


@property (nonatomic, copy) void(^loadMoreContentClick)(BOOL isLoadMore);

+ (void)cellHeightWithContent:(NSString *)content model:(LZYInterviewModel *)model;

+ (BOOL)labelHeigherThanStandardWithContent:(NSString *)content;

@end
