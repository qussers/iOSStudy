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



- (void)requestData
{
    [self.tableView beginLoading];
    [LZYNetwork requestInviteJobWithTableName:nil success:^(NSArray *result) {
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

- (void)configeCell:(LZYInviteJobTableViewCell *)cell model:(LZYInviteJobModel *)model
{
    cell.jobTitle.text = model.jobTitle;
    cell.salaryLabel.text = model.salary;
    cell.companyNameLabel.text = model.companyName;
    cell.companyTypeLabel.text = model.companyType;
    cell.cityNameLabel.text = model.cityName;
    cell.townNameLabel.text = model.townName;
    cell.experienceLabel.text = model.experience;
    cell.inviteUserName.text = model.inviteName;
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
