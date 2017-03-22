//
//  LZYNewsLeftImageTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYNewsLeftImageTableViewCell.h"
#import "LZYGlobalDefine.h"
@implementation LZYNewsLeftImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 86 * LZYSCREEN_WIDTH / 320.0;
}

@end
