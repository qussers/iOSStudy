//
//  LZYUserSaveTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/27.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYUserSaveTableViewController.h"
#import "LZYUserSaveTableViewCell.h"
#import "LZYGlobalDefine.h"
#import "UIView+NetLoadView.h"
#import "LZYNetwork.h"
#import "LZYWebPageModel.h"
#import "LZYBrowserWebViewController.h"

@interface LZYUserSaveTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation LZYUserSaveTableViewController

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


//数据请求
- (void)requestData
{
    [self.tableView beginLoading];
    [LZYNetwork requestObjectModelWithTableName:[LZYWebPageModel class] success:^(NSArray *result) {
        if (result.count == 0) {
            [self.tableView loadNone];
        }else{
            for (LZYWebPageModel *model in result) {
                [LZYUserSaveTableViewCell configeCellHeightWithModel:model];
            }
            [self.tableView endLoading];
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
    
    [LZYNetwork requestObjectModelWithTableName:[LZYWebPageModel class] success:^(NSArray *result) {
        [self endRefreshData];
        for (LZYWebPageModel *model in result) {
            [LZYUserSaveTableViewCell configeCellHeightWithModel:model];
        }
        self.dataSource.array = result;
        [self.tableView reloadData];
    } failure:^(id result) {
        [self.tableView loadError];
    }];
    
}

#pragma mark - UITableViewDataSource
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
    LZYWebPageModel *model = self.dataSource[indexPath.row];
    LZYUserSaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYUserSaveTableViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = model.describe;
    cell.describeLabel.text = model.title;
    cell.timeLabel.text = [self.dateFormatter stringFromDate:model.createdAt];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYUserSaveTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    LZYWebPageModel *model = self.dataSource[indexPath.row];
    LZYBrowserWebViewController *webVc = [[LZYBrowserWebViewController alloc] init];
    webVc.webUrl = model.url;
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYWebPageModel *model = self.dataSource[indexPath.row];
    return model.cellHeight;
}


#pragma mark - lazy
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter =  [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}
@end
