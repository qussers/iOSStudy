//
//  LZYSubmitCollectionViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/19.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSubmitCollectionViewCell.h"
#import "LZYGlobalDefine.h"
#import "UIColor+LZYAdd.h"
@interface LZYSubmitCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation LZYSubmitCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    RAC(self.titleLabel, text) = RACObserve(self, viewModel.modelCount);
    RAC(self.titleLabel, textColor) = [RACObserve(self, viewModel.modelCompleted) map:^id _Nullable(id  _Nullable value) {
        BOOL isCompleted = [value boolValue];
        if (isCompleted) {
            return [UIColor colorWithHexString:MainColor];
        }else{
            return [UIColor blackColor];
        }
    }];
    
}

@end
