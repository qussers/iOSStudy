//
//  LZYExSubmitViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExSubmitViewModel.h"
#import "LZYExDetailCellViewModel.h"

@interface LZYExSubmitViewModel()

@property (nonatomic, strong) RACSignal *loadDataSignal;

@property (nonatomic, strong) NSMutableArray *models;

@property (nonatomic, strong) NSArray *data;


@end


@implementation LZYExSubmitViewModel

+ (instancetype)viewModelWithDataSource:(NSArray *)data
{
 
    return [[self alloc] initWithDataSource:data];
}

- (instancetype)initWithDataSource:(NSArray *)data
{
    if (self = [super init]) {
        _data = data;
    }
    return self;
}

- (void)setUp
{

}

- (NSArray<LZYExSubmitCellViewModel *> *)allData
{
    return self.models;
}

//将传入的操作转变成对应的答案
- (NSMutableArray *)makeModelsFormDetailAnswers:(NSArray *)answers
{
    NSMutableArray *result = @[].mutableCopy;
    for (int i = 0; i < answers.count; i++) {
        LZYExDetailCellViewModel *cellViewModel = answers[i];
        LZYExSubmitModel *model = [[LZYExSubmitModel alloc] init];
        model.index = i;
        model.isCorrect = YES;
        NSMutableArray *yourResults = @[].mutableCopy;
        for (int j = 0; j < cellViewModel.modelExOptions.count; j++) {
            LZYExDetailTableViewCellViewModel *subCellModel = cellViewModel.modelExOptions[j];
            model.isSelected = model.isSelected || subCellModel.isSelected;
            if (subCellModel.isSelected) {
                [yourResults addObject:@(j)];
            }
        }
        if (cellViewModel.modelExAnswers.count != yourResults.count) {
            model.isCorrect = NO;
        }else{
            for (int i = 0; i < cellViewModel.modelExAnswers.count; i++) {
                if ([cellViewModel.modelExAnswers[i] integerValue] != [yourResults[i] integerValue]) {
                    model.isCorrect = NO;
                    break;
                }
            }
        }
        LZYExSubmitCellViewModel *newViewModel = [LZYExSubmitCellViewModel viewModelWithModel:model];
        [result addObject:newViewModel];
    }
    return result;
}

#pragma mark - 业务逻辑

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.allData.count;
}


#pragma mark - lazy
- (NSMutableArray *)models
{
    if (!_models) {
        _models = @[].mutableCopy;
    }
    return _models;
}

- (RACSignal *)loadDataSignal
{
    if (!_loadDataSignal) {
        @weakify(self);
        _loadDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                self.models.array =  [self makeModelsFormDetailAnswers:self.data];
                
                NSLog(@"%@",self.models);
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }
    return _loadDataSignal;
}

@end
