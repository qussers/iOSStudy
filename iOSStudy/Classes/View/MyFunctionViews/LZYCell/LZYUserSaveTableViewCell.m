//
//  LZYUserSaveTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/27.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYUserSaveTableViewCell.h"
#import "LZYWebPageModel.h"
#import "NSString+LZYAdd.h"
#import "LZYGlobalDefine.h"

@implementation LZYUserSaveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (void)configeCellHeightWithModel:(LZYWebPageModel *)model
{
    CGFloat titleHeight = [model.describe stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 16, CGFLOAT_MAX) fontSize:15].height;
    model.cellHeight = 58 * 359 / 375.0 + titleHeight + 18;
}

@end
