//
//  LZYExDetailTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailTableViewCell.h"
#import "UIColor+LZYAdd.h"
#import "LZYGlobalDefine.h"
@interface LZYExDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *optionTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation LZYExDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    RAC(self.contentLabel, text)         = RACObserve(self, viewModel.modelExAnswer);
    RAC(self.optionTitleLabel,text)      = RACObserve(self, viewModel.modelExAnserTitle);
    RAC(self.optionTitleLabel,textColor) = [RACObserve(self, viewModel.isSelected) map:^id _Nullable(id  _Nullable value) {
        if ([value boolValue]) {
            return [UIColor colorWithHexString:MainColor];
        }
        else{
            return [UIColor blackColor];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
