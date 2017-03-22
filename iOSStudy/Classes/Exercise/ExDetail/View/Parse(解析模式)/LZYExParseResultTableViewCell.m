//
//  LZYExParseResultTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExParseResultTableViewCell.h"
#import "UIColor+LZYAdd.h"
#import "LZYGlobalDefine.h"
@interface LZYExParseResultTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *correctLabel;

@property (weak, nonatomic) IBOutlet UILabel *yourLabel;


@end

@implementation LZYExParseResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //属性绑定
    RAC(self.correctLabel, text) = RACObserve(self, viewModel.correctResultsString);
    RAC(self.yourLabel, text) = RACObserve(self, viewModel.yourResultsString);
    RAC(self.yourLabel, textColor) = [RACObserve(self, viewModel.isCorrect) map:^id _Nullable(id  _Nullable value) {
        BOOL isC = [value boolValue];
        if (isC) {
            return [UIColor colorWithHexString:MainColor];
        }
        else{
            return [UIColor redColor];
        }
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
