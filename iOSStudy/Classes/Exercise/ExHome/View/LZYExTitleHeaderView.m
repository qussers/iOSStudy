//
//  LZYExTitleHeaderView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExTitleHeaderView.h"
#import "UIResponder+Router.h"
@interface LZYExTitleHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *indicateBtn;

@property (weak, nonatomic) IBOutlet UIView *titleMidLineView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end


@implementation LZYExTitleHeaderView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    RAC(self.indicateBtn, selected) = [RACObserve(self, viewModel.isSpreadOut) map:^id(id value) {
        return @([value boolValue]);
    }];
    RAC(self.titleMidLineView, alpha) = [RACObserve(self, viewModel.isSpreadOut) map:^id(id value) {
        return @([value boolValue]);
    }];
    RAC(self.bottomLineView, alpha) = [RACObserve(self, viewModel.isSpreadOut) map:^id(id value) {
        return @([value boolValue]);
    }];
    RAC(self.titleLabel, text) = RACObserve(self, viewModel.modelTitleText);
}


- (IBAction)btnClick:(UIButton *)sender {
    
    [[[self.viewModel spreadCommand] execute:nil] subscribeCompleted:^{
        [self.headClickSubject sendCompleted];
    }];
}





@end
