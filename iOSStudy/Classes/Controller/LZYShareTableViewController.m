//
//  LZYShareTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/28.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYShareTableViewController.h"
#import "LZYShareTableViewCell.h"
#import "LZYShareModel.h"
#import "LZYNetwork.h"

#import "UIView+NetLoadView.h"
#import "LZYBrowserSearchWebViewController.h"
#import "LZYUserTool.h"
#import "LZYCommentTool.h"
@interface LZYShareTableViewController ()<LZYShareTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LZYShareTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp
{
    self.hasHeader = YES;
    self.hasFooter = YES;
    
    [super setUp];

}

- (void)requestData
{
    [self.tableView beginLoading];
    [LZYNetwork requestObjectModelWithTableName:[LZYShareModel class] success:^(NSArray *result) {
        if (result.count == 0) {
            [self.tableView loadNone];
        }
        else{
            [self.tableView endLoading];
        }
        for (LZYShareModel *model in result) {
            [LZYShareTableViewCell configeCellHeightWithModel:model];
        }
        self.dataSource.array = result;
        [self.tableView reloadData];
    } failure:^(id result) {
        [self.tableView loadError];
    }];
}

- (void)refreshData
{
    [super refreshData];
    [LZYNetwork requestObjectModelWithTableName:[LZYShareModel class] success:^(NSArray *result) {
        [self endRefreshData];
        for (LZYShareModel *model in result) {
            [LZYShareTableViewCell configeCellHeightWithModel:model];
        }
        self.dataSource.array = result;
        [self.tableView reloadData];
    } failure:^(id result) {
        [self endRefreshData];
    }];

}

- (void)loadMoreData
{
    [super loadMoreData];
    
    LZYShareModel *model = self.dataSource.lastObject;
    LZYBmobQueryTypeModel *queryModel = [[LZYBmobQueryTypeModel alloc] init];
    queryModel.queryValue = model.updatedAt;
    queryModel.queryKeyName = @"updatedAt";
    queryModel.type = kLessThan;
    [LZYNetwork requestObjectModelWithTableName:[LZYShareModel class] conditions:@[queryModel] success:^(NSArray *result) {
        if (result.count == 0) {
            [self noMoreData];
            return;
        }
        [self endLoadMoreData];
        
        for (LZYShareModel *model in result) {
            [LZYShareTableViewCell configeCellHeightWithModel:model];
        }
        [self.dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
    } failure:^(id result) {
        
        [self endLoadMoreData];
    }];

}



#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYShareTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    [cell configeCellWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYShareModel *model = self.dataSource[indexPath.row];
    return model.cellHeight;
}     


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    LZYShareModel *model = self.dataSource[indexPath.row];
    LZYBrowserSearchWebViewController *vc = [[LZYBrowserSearchWebViewController alloc] init];
    vc.webUrl = model.url;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - LZYShareTableViewCellDelegate

//点击用户
- (void)cellDidClickUser:(LZYShareTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LZYShareModel *model = self.dataSource[indexPath.row];
    [LZYUserTool userClickCommentBtnFromViewController:self user:model.user];
}

//点击评论
- (void)cellDidClickComment:(LZYShareTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LZYShareModel *model = self.dataSource[indexPath.row];
    
    LZYCommentBridgeModel *bridge = [[LZYCommentBridgeModel alloc] init];
    bridge.contentObjectId = model.objectId;
    bridge.commentType = kShareComment;
    bridge.pointerObjectName = NSStringFromClass([LZYShareModel class]);
    [LZYCommentTool userClickCommentBtnFromViewController:self commentBridge:bridge];
    
}

//点击赏
- (void)cellDidClickReword:(LZYShareTableViewCell *)cell
{

}

#pragma mark - lazy

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

@end
