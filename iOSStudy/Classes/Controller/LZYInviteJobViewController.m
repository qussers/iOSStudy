//
//  LZYInviteJobViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYInviteJobViewController.h"
#import "LZYNetwork.h"
#import "LZYInviteJobModel.h"
#import "UIView+NetLoadView.h"
#import "LZYInviteJobTableViewCell.h"
#import "LZYGlobalDefine.h"
#import "LZYInviteJobDetailViewController.h"
@interface LZYInviteJobViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LZYInviteJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = (144 - 55) + 55 * LZYSCREEN_WIDTH / 375.0;
    [self requestData];
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
    [LZYNetwork requestObjectModelWithTableName:[LZYInviteJobModel class] success:^(NSArray *result) {
        self.dataSource.array = result;
        [self.tableView reloadData];
        if (result.count > 0) {
            [self.tableView endLoading];
        }else{
            [self.tableView loadNone];
        }
    } failure:^(id result) {
        
        [self.tableView loadError];
    }];
}


- (void)refreshData
{
    [super refreshData];
    [LZYNetwork requestObjectModelWithTableName:[LZYInviteJobModel class] success:^(NSArray *result) {
        [self endRefreshData];
        self.dataSource.array = result;
        [self.tableView reloadData];
    } failure:^(id result) {
        [self endRefreshData];
    }];
    
}


- (void)loadMoreData
{
    [super loadMoreData];
    
    LZYInviteJobModel *model = self.dataSource.lastObject;
    LZYBmobQueryTypeModel *queryModel = [[LZYBmobQueryTypeModel alloc] init];
    queryModel.queryValue = model.updatedAt;
    queryModel.queryKeyName = @"updatedAt";
    queryModel.type = kLessThan;
    
    [LZYNetwork requestObjectModelWithTableName:[LZYInviteJobModel class] conditions:@[queryModel] success:^(NSArray *result) {
        if (result.count == 0) {
            [self noMoreData];
            return;
        }
        [self endLoadMoreData];
        [self.dataSource addObjectsFromArray:result];
        [self tableviewRefresh];
        
    } failure:^(id result) {
        [self endLoadMoreData];
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
    LZYInviteJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inviteJobCell" forIndexPath:indexPath];
    [self configeCell:cell model:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYInviteJobDetailViewController *v = [storyboard instantiateViewControllerWithIdentifier:@"inviteJonDetailViewController"];
    [self.navigationController pushViewController:v animated:YES];
}


- (void)configeCell:(LZYInviteJobTableViewCell *)cell model:(LZYInviteJobModel *)model
{
    cell.jobTitle.text = model.jobTitle;
    cell.salaryLabel.text = model.salary;
    cell.companyNameLabel.text = model.companyName;
    cell.companyTypeLabel.text = model.companyType;
    cell.cityNameLabel.text = model.cityName;
    cell.townNameLabel.text = model.townName;
    cell.experienceLabel.text = model.experience;
    cell.inviteUserName.text = model.userName;
    cell.inviteUserPositon.text = model.invitePosition;

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
