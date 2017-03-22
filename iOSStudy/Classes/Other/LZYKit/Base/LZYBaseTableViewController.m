//
//  LZYBaseTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseTableViewController.h"
#import <MJRefresh.h>
#import "LZYRefreshHeader.h"
@interface LZYBaseTableViewController ()

@end

@implementation LZYBaseTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        _hasFooter = NO;
        _hasHeader = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    [self setUp];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp
{
    if (self.hasHeader) {
        LZYRefreshHeader *header = [LZYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        self.tableView.mj_header = header;
    }

    if (self.hasFooter) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
}


- (void)tableviewRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

//初始化数据请求
- (void)requestData
{
    
}



//数据刷新
- (void)refreshData
{

}

//结束刷新
- (void)endRefreshData
{
    [self.tableView.mj_header endRefreshing];
}

//加载更多
- (void)loadMoreData
{
}

//结束更多加载
- (void)endLoadMoreData
{

    [self.tableView.mj_footer endRefreshing];
}


//没有更多数据
- (void)noMoreData
{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}




@end
