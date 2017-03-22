//
//  LZYExSubTitleCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExSubTitleCell.h"

@interface LZYExSubTitleCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation LZYExSubTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     RAC(self.titleLabel, text) = RACObserve(self, viewModel.modelTitleText);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
