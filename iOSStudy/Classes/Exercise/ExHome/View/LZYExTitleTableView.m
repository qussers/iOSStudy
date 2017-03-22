//
//  LZYExTitleTableView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExTitleTableView.h"
#import "LZYExSubTitleCell.h"
#import "LZYExTitleHeaderView.h"
#import "UIView+Xib.h"
#import "UIColor+LZYAdd.h"
#import "LZYGlobalDefine.h"
#import "UIResponder+Router.h"
@interface LZYExTitleTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LZYExTitleViewModel *viewModel;

@property (nonatomic, strong) RACCommand *fetchDataCommand;

@property (nonatomic, strong) RACCommand *didSelectedRowCommand;

@end

@implementation LZYExTitleTableView

+ (instancetype)instanceWithViewModel:(LZYExTitleViewModel *)viewModel
{
    return [[self alloc] initWithViewModel:viewModel];
}


- (instancetype)initWithViewModel:(LZYExTitleViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:LZYMainBackgroundColor];
    //cell注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYExSubTitleCell class])bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYExSubTitleCell class])];
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
    LZYExSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYExSubTitleCell class]) forIndexPath:indexPath];
    cell.viewModel = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel cellHeightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LZYExTitleHeaderView *header = (LZYExTitleHeaderView *)[LZYExTitleHeaderView loadViewWithXibName:NSStringFromClass([LZYExTitleHeaderView class])];
    header.viewModel = [self.viewModel sectionViewModelInSection:section];
    header.headClickSubject = [RACSubject subject];
    @weakify(self);
    [header.headClickSubject subscribeCompleted:^{
        @strongify(self);
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //执行cell回调点击事件
    [self.tableView routeEvent:LZYExTitleCellDidSelectedEvent userInfo:@{@"value":[self.viewModel cellViewModelForRowAtIndexPath:indexPath]}];
    
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (RACCommand *)fetchDataCommand
{
    if (!_fetchDataCommand) {
        @weakify(self);
        _fetchDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            RACSubject *subject = [RACSubject subject];
            [self.viewModel.refreshDataSignal subscribeError:^(NSError * _Nullable error) {
                NSLog(@"TableView上的signal--->tableView请求失败");
                [subject sendError:error];
            }completed:^{
                NSLog(@"TableView上signal----->tableView请求成功");
                [self.tableView reloadData];
                [subject sendCompleted];
            }];
            return subject;
        }];
    }
    return _fetchDataCommand;
}

@end
