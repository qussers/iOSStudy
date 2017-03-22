//
//  LZYExDetailCellTableView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailCellTableView.h"
#import "LZYExDetailTableViewCell.h"
#import "LZYExDetailTableViewHeaderView.h"
#import "UIResponder+Router.h"
#import "UIView+Xib.h"
#import "UITableView+FDTemplateLayoutCell.h"
NSString *LZYExDetailCellDidSelectedEvent = @"LZYExDetailCellDidSelectedEvent";
@interface LZYExDetailCellTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LZYExDetailCellTableView

+ (instancetype)instanceWitViewModel:(LZYExDetailCellViewModel *)viewModel
{
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(LZYExDetailCellViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)setViewModel:(LZYExDetailCellViewModel *)viewModel
{
    _viewModel = viewModel;
    [self.tableView reloadData];
}

- (void)setUp
{
    //选中条状态
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYExDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYExDetailTableViewCell class])];

}
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYExDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYExDetailTableViewCell class]) forIndexPath:indexPath];
    cell.viewModel = [self.viewModel cellContentAtIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel cellRowHeightAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //改变对应状态
    @weakify(self);
    [[[self.viewModel cellDidClick] execute:@(indexPath.row)] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //数据处理完成--->传递至视图进行视图操作
        [self.cellClickSubject sendNext:x];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LZYExDetailTableViewHeaderView *view = (LZYExDetailTableViewHeaderView *)[UIView loadViewWithXibName:NSStringFromClass([LZYExDetailTableViewHeaderView class])];
    view.viewModel = self.viewModel;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return [self.viewModel heightForHeaderInSection:section];
}


#pragma mark - lazy

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self setUp];
    }
    return _tableView;
}



@end
