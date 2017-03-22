//
//  LZYMoreButtonTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYMoreButtonTableViewCell.h"
#import "LZYGlobalDefine.h"
@implementation LZYMoreButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    for (int i = 0 ; i < 8; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        UIView *subView = [self.buttonsView viewWithTag:i + 1];
        [subView addGestureRecognizer:tap];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didClickButtonIndex:)]) {
        [self.delegate cell:self didClickButtonIndex:tap.view.tag - 1];
    }
}

- (IBAction)buttonClick:(id)sender {
    
    NSInteger index = [(UIButton *)sender tag] - 10;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didClickButtonIndex:)]) {
        [self.delegate cell:self didClickButtonIndex:index];
    }
    
}



+ (CGFloat)cellHeight
{
    return   169 * (LZYSCREEN_WIDTH - 16) / 320;
}

@end
