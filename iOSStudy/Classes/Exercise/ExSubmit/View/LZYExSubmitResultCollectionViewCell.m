//
//  LZYExSubmitResultCollectionViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExSubmitResultCollectionViewCell.h"
#import "UIColor+LZYAdd.h"
#import "LZYGlobalDefine.h"
@implementation LZYExSubmitResultCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    RAC(self.titleLabel, text) = RACObserve(self, viewModel.modelCount);
    RAC(self.titleLabel, textColor) = [RACObserve(self, viewModel.modelCorrect) map:^id _Nullable(id  _Nullable value) {
        BOOL isC = [value boolValue];
        if (isC) {
            return [UIColor colorWithHexString:MainColor];
        }else{
            return [UIColor redColor];
        }
    }];
}

@end
