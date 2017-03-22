//
//  LZYExParseCellTableView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExParseCellTableView.h"
#import "LZYExDetailTableViewCell.h"
#import "LZYExParseResultTableViewCell.h"
#import "LZYCommentTableViewCell.h"
#import "LZYExParseDiscussTableViewCell.h"
#import "MBProgressHUD+LZYAdd.h"
#import <MJRefresh.h>
#import "LZYRefreshHeader.h"
@implementation LZYExParseCellTableView

- (void)setUp
{
    [self.tableView setAllowsSelection:NO];
    //选中条状态
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYExDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYExDetailTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYExParseResultTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYExParseResultTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYExParseDiscussTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYExParseDiscussTableViewCell class])];
    
}

- (void)addHeaderAndFooter
{

    @weakify(self);
    self.tableView.mj_header = [LZYRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        [((LZYExParseCellViewModel *)self.viewModel).refreshDataSignal subscribeError:^(NSError * _Nullable error) {
            NSLog(@"出错了");
            [self.tableView.mj_header endRefreshing];
        } completed:^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [((LZYExParseCellViewModel *)self.viewModel).loadMoreDataSignal subscribeNext:^(id  _Nullable x) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } completed:^{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }];
        
    }];
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
    if (indexPath.section == 0) {
        if (indexPath.row < ([self.viewModel numberOfRowsInSection:indexPath.section] - 1)) {
            LZYExDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYExDetailTableViewCell class]) forIndexPath:indexPath];
            cell.viewModel = [self.viewModel cellContentAtIndexPath:indexPath];
            return cell;
        }
        else{
            LZYExParseResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYExParseResultTableViewCell class]) forIndexPath:indexPath];
            cell.viewModel = [(LZYExParseCellViewModel *)self.viewModel resultViewModel];
            return cell;
        }
    }

    if (indexPath.section == 1) {
        
        if(((LZYExParseCellViewModel *)self.viewModel).discussDataSource.count == 0){
            LZYExParseDiscussTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYExParseDiscussTableViewCell class]) forIndexPath:indexPath];
            cell.viewModel = (LZYExParseCellViewModel *)self.viewModel;
            
            @weakify(self);
            [[cell.disBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                [[((LZYExParseCellViewModel *)self.viewModel).discussClickCommand execute:nil] subscribeNext:^(id  _Nullable x) {
                    if ([x isEqualToString:@"数据位空"]) {
                        [MBProgressHUD showError:@"暂无数据哦😯"];
                    }
                }completed:^{
                    @strongify(self);
                    [self.tableView reloadData];
                    [self addHeaderAndFooter];
                }];
            }];
            return cell;
        }
        
        
        LZYCommentTableViewCell *cell  = [tableView  dequeueReusableCellWithIdentifier:NSStringFromClass([LZYCommentTableViewCell class])];
        if (!cell) {
            cell = [[LZYCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LZYCommentTableViewCell class])];
            cell.delegate = self;
        }
        [cell configeCellWithLayoutModel:((LZYExParseCellViewModel *)self.viewModel).discussDataSource[indexPath.row]];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [self.viewModel cellRowHeightAtIndexPath:indexPath];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
