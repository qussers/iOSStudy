//
//  LZYExSubTitleViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExCellSubTitleViewModel.h"

@interface LZYExCellSubTitleViewModel ()

@property (nonatomic, strong) LZYExSubTitleModel *model;


@end

@implementation LZYExCellSubTitleViewModel

+ (instancetype)viewModelWithSubTitleModel:(LZYExSubTitleModel *)model
{
    return [[self alloc] initWithSubTitleModel:model];
}

- (instancetype)initWithSubTitleModel:(LZYExSubTitleModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}


- (NSString *)modelTitleText
{
    return self.model.title;
}
@end
