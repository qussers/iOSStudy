//
//  LZYBaseTableViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+NetLoadView.h"
@interface LZYBaseTableViewController : UITableViewController

@property (nonatomic, assign) BOOL hasHeader;

@property (nonatomic, assign) BOOL hasFooter;

//刷新列表
- (void)tableviewRefresh;

//初始化请求数据
- (void)requestData;

//刷新数据
- (void)refreshData;

//结束刷新
- (void)endRefreshData;

//加载更多数据
- (void)loadMoreData;

- (void)noMoreData;

- (void)endLoadMoreData;

- (void)setUp;


@end
