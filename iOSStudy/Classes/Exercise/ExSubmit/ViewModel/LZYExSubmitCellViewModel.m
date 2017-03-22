//
//  LZYExSubmitCellViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExSubmitCellViewModel.h"

@interface LZYExSubmitCellViewModel()

@property (nonatomic, strong) LZYExSubmitModel *model;

@end

@implementation LZYExSubmitCellViewModel

+ (instancetype)viewModelWithModel:(LZYExSubmitModel *)model
{
    return [[self alloc] initWithModel:model];
}

- (instancetype)initWithModel:(LZYExSubmitModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (NSString *)modelCount
{
    return [NSString stringWithFormat:@"%ld",self.model.index];
}

- (BOOL)modelCompleted
{
    return self.model.isSelected;
}

- (BOOL)modelCorrect
{
    return self.model.isCorrect;
}

@end
