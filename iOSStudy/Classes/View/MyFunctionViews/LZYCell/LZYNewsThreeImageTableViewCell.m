//
//  LZYNewsThreeImageTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/26.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYNewsThreeImageTableViewCell.h"
#import "LZYGlobalDefine.h"
@implementation LZYNewsThreeImageTableViewCell

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
    return 144 * LZYSCREEN_WIDTH / 320.0;
}
@end
