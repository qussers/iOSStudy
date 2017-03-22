//
//  LZYExDetailTableViewHeaderView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailTableViewHeaderView.h"

@implementation LZYExDetailTableViewHeaderView


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    RAC(self.exTypeLabel, text) = RACObserve(self, viewModel.modelExType);
    RAC(self.exTitleLabel, text) = RACObserve(self, viewModel.modelExTitle);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
