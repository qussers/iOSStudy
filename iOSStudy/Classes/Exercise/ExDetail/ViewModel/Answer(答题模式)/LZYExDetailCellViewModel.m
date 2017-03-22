//
//  LZYExDetailCellViewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailCellViewModel.h"
#import "NSString+LZYAdd.h"
#import "LZYGlobalDefine.h"
@interface LZYExDetailTableViewCellViewModel()

@property (nonatomic, strong) LZYExDetailAnswerModel *model;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) RACCommand *selected;

@property (nonatomic, strong) RACCommand *chancelSelected;



@end

@implementation LZYExDetailTableViewCellViewModel

+ (instancetype)viewModelWithModel:(LZYExDetailAnswerModel *)model
{
    return [[self alloc] initWithModel:model];
}

- (instancetype)initWithModel:(LZYExDetailAnswerModel *)model
{
    if (self = [super init]) {
        _model = model;
        _isSelected = NO;
    }
    
    return self;
}

- (NSString *)modelExAnswer
{
    return self.model.content;
}

- (NSString *)modelExAnserTitle
{
    NSArray *abc = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N"];
    return abc[self.model.index];
}

#pragma mark - lazy

- (RACCommand *)selected
{
    if (!_selected) {
        @weakify(self);
        _selected = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            self.isSelected = YES;
            return [RACSignal empty];
        }];
    }
    return _selected;
}

- (RACCommand *)chancelSelected
{
    if (!_chancelSelected) {
        @weakify(self);
        _chancelSelected = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            self.isSelected = NO;
            return [RACSignal empty];
        }];
    }
    return _chancelSelected;

}

@end



@interface LZYExDetailCellViewModel()

@property (nonatomic, strong) LZYExDetailModel *model;

@property (nonatomic, strong) NSMutableArray *optionViewModels;

@property (nonatomic, strong) RACCommand *cellDidClick;

@end

@implementation LZYExDetailCellViewModel

+ (instancetype)viewModelWithModel:(LZYExDetailModel *)model
{
    return [[self alloc] initWithModel:model];
}

- (instancetype)initWithModel:(LZYExDetailModel *)model
{
    if (self = [super init]) {
        _model = model;
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    for (int i = 0; i < self.model.options.count; i++) {
        LZYExDetailAnswerModel *aModel = [[LZYExDetailAnswerModel alloc] init];
        aModel.index = i;
        aModel.content = self.model.options[i];
        [self.optionViewModels addObject:[LZYExDetailTableViewCellViewModel viewModelWithModel:aModel]];
    }
}


- (NSString *)modelExTitle
{
    return self.model.title;
}

- (NSArray *)modelExAnswers
{
    return self.model.answers;
}

-(NSArray <LZYExDetailTableViewCellViewModel *>*)modelExOptions
{
    return self.optionViewModels;
}

- (NSString *)modelExType
{
    switch (self.model.exType) {
        case 0:
            return @"(单选题)";
            break;
        case 1:
            return @"(多选题)";
            break;
        default:
            break;
    }
    return nil;
}

//根据状态决定效果
- (void)setUpSubViewModelSelectedWithIndex:(NSInteger)index
{
    for (int i = 0; i < self.optionViewModels.count; i++) {
        LZYExDetailTableViewCellViewModel *subViewModel = self.optionViewModels[i];
        if (self.model.exType == 0) {
            if (index == i) {
                [subViewModel.selected execute:nil];
            }else{
                [subViewModel.chancelSelected execute:nil];
            }
        }else{
            if (index == i) {
                subViewModel.isSelected ? [subViewModel.chancelSelected execute:nil] :  [subViewModel.selected execute:nil];
            }
        }
    }
}

/*********************业务逻辑**********************/

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [[self modelExOptions] count];
}

- (LZYExDetailTableViewCellViewModel *)cellContentAtIndexPath:(NSIndexPath *)indexPath
{
    return  self.optionViewModels[indexPath.row];
}

- (CGFloat)cellRowHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    CGSize size = [self.model.title stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 16, CGFLOAT_MAX) fontSize:17];
    return size.height + 35;
}

#pragma mark - lazy
- (NSMutableArray *)optionViewModels
{
    if (!_optionViewModels) {
        _optionViewModels = @[].mutableCopy;
    }
    return _optionViewModels;
}

- (RACCommand *)cellDidClick
{
    if (!_cellDidClick) {
        @weakify(self);
        _cellDidClick = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            NSInteger index = [input integerValue];
            //设置对应选中数据状态
            [self setUpSubViewModelSelectedWithIndex:index];
            RACSignal *singal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@(self.model.exType)];
                [subscriber sendCompleted];
                return nil;
            }];
            return singal;
        }];
    }
    return _cellDidClick;
}
@end
