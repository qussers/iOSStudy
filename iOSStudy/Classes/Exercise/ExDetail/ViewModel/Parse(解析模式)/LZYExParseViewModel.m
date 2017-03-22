//
//  LZYExParseViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExParseViewModel.h"
#import "LZYExParseCellViewModel.h"
@interface LZYExParseViewModel()

@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation LZYExParseViewModel

+ (instancetype)instanceWithViewModel:(LZYExDetailViewModel *)viewModel
{
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(LZYExDetailViewModel *)viewModel
{
    if (self = [super init]) {
        
        [self setUpWithViewModel:viewModel];
    }
    return self;
}

- (void)setUpWithViewModel:(LZYExDetailViewModel *)viewModel
{
    for (LZYExDetailCellViewModel *cellVM in viewModel.allData) {
        [self.models addObject:[LZYExParseCellViewModel parseViewModelWithBaseViewModel:cellVM]];
    }
}


#pragma mark -

- (NSMutableArray *)models
{
    if (!_models) {
        _models = @[].mutableCopy;
    }
    return _models;
}

@end
