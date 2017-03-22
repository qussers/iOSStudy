//
//  LZYExParseCollectionView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExParseCollectionView.h"
#import "LZYExParseCollectionViewCell.h"

@interface LZYExParseCollectionView ()

@property (nonatomic, strong) RACCommand *parseDataCommand;

@end

@implementation LZYExParseCollectionView


- (void)setUp
{
    [self.collectionView setAllowsSelection:NO];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LZYExParseCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LZYExParseCollectionViewCell class])];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LZYExParseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LZYExParseCollectionViewCell class]) forIndexPath:indexPath];
    cell.viewModel = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    return cell;
}


#pragma mark - lazy

- (RACCommand *)parseDataCommand
{
    if (!_parseDataCommand) {
        @weakify(self);
        _parseDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            [self.collectionView reloadData];
            return [RACSignal empty];
        }];
    }
    return _parseDataCommand;
}

@end
