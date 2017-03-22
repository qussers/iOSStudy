//
//  LZYExTitleViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExTitleViewModel.h"
#import <RACEXTScope.h>
#import "LZYNetwork.h"


//跨层解耦事件
NSString *LZYExTitleCellDidSelectedEvent = @"LZYExTitleCellDidSelectedEven";


@interface LZYExTitleViewModel ()
@property (nonatomic, strong) NSMutableArray<LZYExCellTitleViewModel *> *models;

@property (nonatomic, strong) RACSignal *refreshDataSignal;

@property (nonatomic, strong) RACSignal *loadMoreDataSignal;

@end

@implementation LZYExTitleViewModel

+ (instancetype)viewModel
{
    
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    
    return self;
}



- (void)setUp
{

    @weakify(self);
    self.refreshDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSLog(@"viewModel开始进行数据请求---->begin~~~~");
        
        //加入对应查询条件
        LZYBmobQueryTypeModel *condition = [[LZYBmobQueryTypeModel alloc] init];
        condition.queryKeyName = @"titleModel";
        condition.type = kIncludeKey;
        //获取对应数据,并转模型
        [LZYNetwork requestObjectModelWithTableName:[LZYExSubTitleModel class]
                                         conditions:@[condition]
                                            success:^(NSArray *result) {
            //拿到子模型以及相应数据
            for (LZYExSubTitleModel *subModel in result) {
                //先创建subViewModel
                LZYExCellSubTitleViewModel *subViewModel = [LZYExCellSubTitleViewModel viewModelWithSubTitleModel:subModel];
                if ([[self.models valueForKeyPath:@"model.objectId"] containsObject:subViewModel.model.titleModel.objectId]) {
                    for (LZYExCellTitleViewModel *cellTitleViewModel in self.models) {
                        if ([subViewModel.model.titleModel.objectId isEqualToString:cellTitleViewModel.model.objectId]) {
                            [cellTitleViewModel addSubViewModel:subViewModel];
                            break;
                        }
                    }
                }else{
                    
                    LZYExTitleModel *titleModel = [[LZYExTitleModel alloc] initFromBmobObject:subModel.titleModel];
                    LZYExCellTitleViewModel *titleViewModel = [LZYExCellTitleViewModel viewModelWithModel:titleModel];
                    [titleViewModel addSubViewModel:subViewModel];
                    if (self.models.count == 0) {
                        //如果是第一个就展开
                        [titleViewModel.spreadCommand execute:nil];
                    }
                    [self.models addObject:titleViewModel];
                }
            }
            
            NSLog(@"viewModel数据请求结束成功~~~~~~>Completed");
            [subscriber sendCompleted];
            
        } failure:^(id result) {
            NSLog(@"viewModel数据请求失败------->error");
            [subscriber sendError:nil];
        }];
        
        return nil;
    }];
}

- (NSArray <LZYExCellTitleViewModel *>*)allDatas
{
    return self.models;
}



//返回有几个分组
- (NSInteger)numberOfSections
{
    return self.allDatas.count;
}

//返回分个分组有多少元素
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    LZYExCellTitleViewModel *cellViewModel = [self allDatas][section];
    return cellViewModel.isSpreadOut ? cellViewModel.subViewModels.count : 0;
}

- (LZYExCellTitleViewModel *)sectionViewModelInSection:(NSInteger)section
{
    return self.allDatas[section];

}

//返回对应的viewmodel
- (LZYExCellSubTitleViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYExCellTitleViewModel *cellViewModel = [self allDatas][indexPath.section];
    return cellViewModel.subViewModels[indexPath.row];
}

//返回cell高度
- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


#pragma mark - lazy
- (NSMutableArray<LZYExCellTitleViewModel *> *)models
{
    if (!_models) {
        _models = @[].mutableCopy;
    }
    return _models;

}


@end
