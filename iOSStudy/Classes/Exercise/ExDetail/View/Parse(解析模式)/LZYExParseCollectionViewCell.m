//
//  LZYExParseCollectionViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExParseCollectionViewCell.h"
#import "LZYExParseCellTableView.h"

@interface LZYExParseCollectionViewCell()

@property (nonatomic, strong) LZYExParseCellTableView *tableView;

@end

@implementation LZYExParseCollectionViewCell

#pragma mark - lazy
- (LZYExParseCellTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LZYExParseCellTableView instanceWitViewModel:self.viewModel];
    }
    return _tableView;
}


@end
