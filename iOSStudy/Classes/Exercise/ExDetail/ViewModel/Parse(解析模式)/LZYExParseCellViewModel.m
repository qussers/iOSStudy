//
//  LZYExParseCellViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExParseCellViewModel.h"
#import "LZYGlobalDefine.h"
#import "NSString+LZYAdd.h"
#import "LZYNetwork.h"
#import "LZYCommentModel.h"
#import "LZYCommentLayoutModel.h"
@implementation LZYExParseResultViewModel


- (NSString *)correctResultsString
{
    NSString *result = @"";
    for (NSString *item in self.correctResults) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%@ ", [self transNumberToABCWithNumber:item]]];
    }
    return result;
}

- (NSString *)yourResultsString
{
    NSString *result = @"";
    for (NSString *item in self.yourResults) {
       
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%@ ", [self transNumberToABCWithNumber:item]]];
    }
    if (self.isCorrect) {
        result = [result stringByAppendingString:@"(正确)"];
    }
    else{
        result = [result stringByAppendingString:@"(错误)"];
    }
    return result;
}

- (NSString *)transNumberToABCWithNumber:(NSString *)number
{
    switch ([number integerValue]) {
        case 0:
            return @"A";
            break;
        case 1:
            return @"B";
            break;
        case 2:
            return @"C";
            break;
        case 3:
            return @"D";
            break;
        case 4:
            return @"E";
            break;
        case 5:
            return @"F";
            break;
        case 6:
            return @"G";
            break;
        case 7:
            return @"H";
            break;
        case 8:
            return @"I";
            break;
        case 9:
            return @"J";
            break;
        case 10:
            return @"K";
            break;
        default:
            return @"Z";
            break;
    }
}

- (BOOL)isCorrect
{
    //对比答案和正确答案(在对象生成时确认升序排列)
    if(self.correctResults.count != self.yourResults.count){
        return NO;
    }
    for (int i = 0; i < self.yourResults.count; i++) {
        if ([self.yourResults[i] integerValue] != [self.correctResults[i] integerValue]) {
            return NO;
        }
    }
    return YES;
}

@end


@interface LZYExParseCellViewModel()

@property (nonatomic, strong) LZYExDetailModel *model;

@property (nonatomic, strong) NSArray *optionViewModels;

@property (nonatomic, strong) LZYExParseResultViewModel *resultViewModel;

@property (nonatomic, strong) RACCommand *discussClickCommand;

@property (nonatomic, strong) RACSignal *refreshDataSignal;

@property (nonatomic, strong) RACSignal *loadMoreDataSignal;

//讨论结果集合
@property (nonatomic, strong) NSMutableArray *discussDataSource;

@end

@implementation LZYExParseCellViewModel

+ (instancetype)parseViewModelWithBaseViewModel:(LZYExDetailCellViewModel *)viewModel
{
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(LZYExDetailCellViewModel *)viewModel
{
    if (self = [super init]) {
        _model = viewModel.model;
        _optionViewModels = viewModel.modelExOptions;
        _resultViewModel = [self addResultViewModel];
    }
    return self;
}

//转换为内部是用viewModel
- (LZYExParseResultViewModel *)addResultViewModel
{
    LZYExParseResultViewModel *resultViewModel = [[LZYExParseResultViewModel alloc] init];
    resultViewModel.correctResults = self.model.answers;
    NSMutableArray *yourResults = @[].mutableCopy;
    for (int i = 0; i < self.optionViewModels.count; i++) {
        LZYExDetailTableViewCellViewModel *subViewModel = self.optionViewModels[i];
        if (subViewModel.isSelected) {
            [yourResults addObject:@(i)];
        }
    }
    resultViewModel.yourResults = yourResults;
    return resultViewModel;
}


/*********************业务逻辑**********************/
- (NSInteger)numberOfSections
{
    return 2;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
      return [[self modelExOptions] count] + 1;
    }
    if (section == 1) {
        if(self.discussDataSource.count == 0){
            return 1;
        }
        return self.discussDataSource.count;
    }
    return 0;
}

- (LZYExDetailTableViewCellViewModel *)cellContentAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.optionViewModels[indexPath.row];
    }
    return nil;
   
}

- (CGFloat)cellRowHeightAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    if (indexPath.section == 1) {
        
        if(self.discussDataSource.count == 0){
            return 44;
        }
        LZYCommentLayoutModel *layoutModel = self.discussDataSource[indexPath.row];
        return  layoutModel.cellFrame.size.height;
    }
    return 0;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CGSize size = [self.model.title stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 16, CGFLOAT_MAX) fontSize:17];
        return size.height + 35;
    }

    return 0;
}

#pragma mark - lazy
- (RACCommand *)discussClickCommand
{
    if (!_discussClickCommand) {
        @weakify(self);
        _discussClickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return self.refreshDataSignal;
        }];
    }
    return _discussClickCommand;
}


- (RACSignal *)refreshDataSignal
{
    @weakify(self);
    _refreshDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        LZYBmobQueryTypeModel *model = [[LZYBmobQueryTypeModel alloc] init];
        model.queryKeyName = @"pointerId";
        model.queryValue = self.model.objectId;
        model.type = kEqual;
        [LZYNetwork requestObjectModelWithTableName:[LZYCommentModel class] conditions:@[model] success:^(NSArray *result) {
            [self.discussDataSource removeAllObjects];
            for (LZYCommentModel *model in result) {
                LZYCommentLayoutModel *layoutModel = [[LZYCommentLayoutModel alloc] initWithModel:model];
                [self.discussDataSource addObject:layoutModel];
            }
            if (result.count > 0) {
                [subscriber sendCompleted];
            }
            else{
                [subscriber sendNext:@"数据为空"];
            }
        } failure:^(id result) {
            [subscriber sendError:nil];
        }];
        return nil;
    }];
    
    return _refreshDataSignal;
}


- (RACSignal *)loadMoreDataSignal
{
    @weakify(self);
    _loadMoreDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);

        LZYCommentLayoutModel *model = self.discussDataSource.lastObject;
        LZYBmobQueryTypeModel *queryModel = [[LZYBmobQueryTypeModel alloc] init];
        queryModel.queryKeyName = @"pointerId";
        queryModel.queryValue = self.model.objectId;
        queryModel.type = kEqual;
        
        LZYBmobQueryTypeModel *queryModel2 = [[LZYBmobQueryTypeModel alloc] init];
        queryModel2.queryValue = model.model.updatedAt;
        queryModel2.queryKeyName = @"updatedAt";
        queryModel2.type = kLessThan;
        [LZYNetwork requestObjectModelWithTableName:[LZYCommentModel class] conditions:@[queryModel,queryModel2] success:^(NSArray *result) {
            for (LZYCommentModel *model in result) {
                LZYCommentLayoutModel *layoutModel = [[LZYCommentLayoutModel alloc] initWithModel:model];
                [self.discussDataSource addObject:layoutModel];
            }
            if (result.count > 0) {
                [subscriber sendCompleted];
            }
            else{
                [subscriber sendNext:@"没有更多数据"];
            }
        } failure:^(id result) {
            [subscriber sendError:nil];
        }];
        
        return nil;
    }];
    return _loadMoreDataSignal;
}

- (NSMutableArray *)discussDataSource
{
    if (!_discussDataSource) {
        _discussDataSource = @[].mutableCopy;
    }
    return _discussDataSource;
}


@end
