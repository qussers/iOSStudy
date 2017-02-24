//
//  LZYPersonView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/18.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYPersonBackgroundView.h"

@implementation LZYPersonBackgroundView

- (IBAction)iconViewClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(iconViewClick)]) {
        [self.delegate iconViewClick];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self layoutIfNeeded];
     self.iconImageView.layer.cornerRadius = CGRectGetWidth(self.iconImageView.frame) / 2.0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.iconImageView.layer.masksToBounds) {
        self.iconImageView.layer.masksToBounds  = YES;
    }
}

@end
