//
//  LZYExDetailCollectionView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailCollectionView.h"
#import "LZYExDetailCollectionViewCell.h"
#import "UIResponder+Router.h"

@interface LZYExDetailCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) LZYExDetailViewModel *viewModel;

@property (nonatomic, strong) RACCommand *fetchDataCommand;

@end

@implementation LZYExDetailCollectionView


+ (instancetype)instanceWithViewModel:(LZYExDetailViewModel *)viewModel
{
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(LZYExDetailViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LZYExDetailCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LZYExDetailCollectionViewCell class])];
}

- (LZYExDetailModel *)currentModel
{    
    return [self.viewModel cellViewModelForRowAtIndexPath:[self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset]].model;
}

#pragma mark - UICollectionDataSource & UICollectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.viewModel numberOfItemsInSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LZYExDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LZYExDetailCollectionViewCell class]) forIndexPath:indexPath];
    cell.viewModel = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    cell.cellClickSubject = [RACSubject subject];
    [cell.cellClickSubject subscribeNext:^(id  _Nullable x) {
        //单选处理
        if ([x integerValue] == 0) {
            if (indexPath.row < ([self.viewModel numberOfItemsInSection:indexPath.section] - 1 )) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            }
            
            if (indexPath.row >= ([self.viewModel numberOfItemsInSection:indexPath.section] - 1 )) {
                [self.allOptionCompletedSubject sendNext:self.viewModel.allData];
            }
        }
        
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > self.collectionView.frame.size.width * (self.viewModel.allData.count - 1)) {
       [self.allOptionCompletedSubject sendNext:self.viewModel.allData];
    }
}


#pragma mark - lazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
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
            [self.viewModel.refreshDataSignal subscribeError:^(NSError * _Nullable error) {
                [subject sendError:error];
            } completed:^{
                //刷新视图
                [self.collectionView reloadData];
                [subject sendCompleted];
            }];
            return subject;
        }];
    }
    return _fetchDataCommand;
}



@end
