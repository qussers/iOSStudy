//
//  LZYExDetailCollectionViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailCollectionViewCell.h"
#import "LZYExDetailCellTableView.h"
@interface LZYExDetailCollectionViewCell()


@property (nonatomic, strong) LZYExDetailCellTableView *tableView;

@end

@implementation LZYExDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    RAC(self.tableView, cellClickSubject) = RACObserve(self, cellClickSubject);
    self.tableView.tableView.frame = self.bounds;
    [self.contentView addSubview:self.tableView.tableView];
}


- (void)setViewModel:(LZYExDetailCellViewModel *)viewModel
{
    _viewModel = viewModel;
    self.tableView.viewModel = viewModel;
}


#pragma mark - lazy
- (LZYExDetailCellTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LZYExDetailCellTableView instanceWitViewModel:self.viewModel];
    }
    return _tableView;
}

@end
