//
//  LZYExSubmitView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExSubmitView.h"
#import "LZYSubmitCollectionViewCell.h"
#import "LZYExSubmitResultCollectionViewCell.h"
@interface LZYExSubmitView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) LZYExSubmitViewModel *viewModel;

@property (nonatomic, strong) RACCommand *fetchDataCommand;

@property (nonatomic, strong) RACCommand *submitDataCommand;

@end

@implementation LZYExSubmitView

+ (instancetype)instanceWithViewModel:(LZYExSubmitViewModel *)viewModel
{
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(LZYExSubmitViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
        _type = kOverView;
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYSubmitCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([LZYSubmitCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYExSubmitResultCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([LZYExSubmitResultCollectionViewCell class])];

}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == kOverView) {
        LZYSubmitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LZYSubmitCollectionViewCell class]) forIndexPath:indexPath];
        cell.viewModel = self.viewModel.allData[indexPath.row];
        return cell;
    }
    else{
        LZYExSubmitResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LZYExSubmitResultCollectionViewCell class]) forIndexPath:indexPath];
        cell.viewModel = self.viewModel.allData[indexPath.row];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(44, 44);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == kOverView) {
        //点击事件处理
        [self.cellDidClickSubject sendNext:@(indexPath.row)];
    }
    else{
        [self.completedClickSubject sendNext:@(indexPath.row)];
    }
  
}

#pragma mark - lazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (RACCommand *)fetchDataCommand
{
    if (!_fetchDataCommand) {
        @weakify(self);
        _fetchDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            RACSubject *subject = [RACSubject subject];
            [self.viewModel.loadDataSignal subscribeCompleted:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                    [subject sendCompleted];
                });
            }];
            return subject;
        }];
    }
    return _fetchDataCommand;
}

- (RACCommand *)submitDataCommand
{
    if (!_submitDataCommand) {
        @weakify(self);
        _submitDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            self.type = kResult;
            [self.collectionView reloadData];
            return [RACSignal empty];
        }];
    }
    
    return _submitDataCommand;
}

@end
