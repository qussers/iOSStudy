//
//  LZYUserSaveTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/27.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZYWebPageModel;

@interface LZYUserSaveTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *urlImageView;

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *tabLabel;

+ (void)configeCellHeightWithModel:(LZYWebPageModel *)model;

@end
