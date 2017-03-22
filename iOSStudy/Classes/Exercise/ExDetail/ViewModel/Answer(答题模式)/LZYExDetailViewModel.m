//
//  LZYExDetailViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailViewModel.h"
#import "LZYNetwork.h"

@interface LZYExDetailViewModel()

@property (nonatomic, strong) NSMutableArray <LZYExDetailCellViewModel *>* models;

@property (nonatomic, strong) RACSignal *refreshDataSignal;

@property (nonatomic, strong) RACSignal *loadMoreDataSignal;

//
@property (nonatomic, copy) NSString *URLId;

@end

@implementation LZYExDetailViewModel

+ (instancetype)viewModelWithObjectId:(NSString *)objectId
{
    return [[self alloc ] initWithObjectId:objectId];
}

- (instancetype)initWithObjectId:(NSString *)objectId
{
    if (self = [super init]) {
        _URLId = objectId;
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    

}

- (NSArray<LZYExDetailCellViewModel *> *)allData
{
    return self.models;
}



/*********************业务逻辑***************************/

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (LZYExDetailCellViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.models[indexPath.row];
}


#pragma mark - lazy
- (NSMutableArray<LZYExDetailCellViewModel *> *)models
{
    if (!_models) {
        _models = @[].mutableCopy;
    }
    return _models;
}

- (RACSignal *)refreshDataSignal
{
    if (!_refreshDataSignal) {
        @weakify(self);
        _refreshDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            LZYBmobQueryTypeModel *queryModel = [[LZYBmobQueryTypeModel alloc] init];
            queryModel.queryKeyName = @"pointerId";
            queryModel.queryValue = self.URLId;
            queryModel.type = kEqual;
           [LZYNetwork requestObjectModelWithTableName:[LZYExDetailModel class]
                                            conditions:@[queryModel]
                                               success:^(NSArray *result) {
               [self.models removeAllObjects];
               for (LZYExDetailModel *model in result) {
                   LZYExDetailCellViewModel *viewModel = [LZYExDetailCellViewModel viewModelWithModel:model];
                   [self.models addObject:viewModel];
               }
               [subscriber sendCompleted];
           } failure:^(id result) {
               [subscriber sendError:nil];
           }];
            return nil;
        }];
    }
    return _refreshDataSignal;
}


- (RACSignal *)loadMoreDataSignal
{
    if (!_loadMoreDataSignal) {
        _loadMoreDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            return nil;
        }];
    }
    
    return _loadMoreDataSignal;

}



@end
