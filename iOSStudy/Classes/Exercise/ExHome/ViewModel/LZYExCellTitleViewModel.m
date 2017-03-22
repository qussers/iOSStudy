//
//  LZYExCellTitleViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExCellTitleViewModel.h"


NSString *SpreadEvent = @"SpreadEvent";
NSString *kCellViewModel = @"kCellViewModel";

@interface LZYExCellTitleViewModel ()

@property (nonatomic, strong) LZYExTitleModel *model;
@property (nonatomic, strong) NSMutableArray <LZYExCellSubTitleViewModel *> *subModels;

@property (nonatomic, assign) BOOL isSpreadOut;

@property (nonatomic, strong) RACCommand *spreadCommand;

@end

@implementation LZYExCellTitleViewModel

+ (instancetype)viewModelWithModel:(LZYExTitleModel *)model
{
    return [[self alloc] initWithModel:model];
}

- (instancetype)initWithModel:(LZYExTitleModel *)model
{
    if (self = [super init]) {
        _model = model;
        _isSpreadOut = NO;
        [self setUp];
    }
    return self;
}


- (void)setUp
{
    @weakify(self);
    self.spreadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
           self.isSpreadOut = !self.isSpreadOut;
           return  [RACSignal empty];
    }];

}



- (void)addSubViewModel:(LZYExCellSubTitleViewModel *)subViewModel
{
    [self.subModels addObject:subViewModel];
}

- (NSArray<LZYExCellSubTitleViewModel *> *)subViewModels
{
    return self.subModels;
}

- (NSString *)modelTitleText
{
    return self.model.title;
}



#pragma mark - lazy

- (NSMutableArray<LZYExCellSubTitleViewModel *> *)subModels
{
    if (!_subModels) {
        _subModels = @[].mutableCopy;
    }
    return _subModels;
}

@end
