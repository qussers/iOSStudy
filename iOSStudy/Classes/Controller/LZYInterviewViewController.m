//
//  LZYInterviewViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYInterviewViewController.h"
#import "LZYInterviewModel.h"
#import "LZYNetwork.h"
#import "UIView+NetLoadView.h"
#import "LZYInterviewTableViewCell.h"
#import "LZYGlobalDefine.h"

#import "LZYCommentViewController.h"

@interface LZYInterviewViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation LZYInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUp
{
    self.hasFooter = YES;
    self.hasHeader = YES;
    
    [super setUp];
}

- (void)requestData
{
    [self.tableView beginLoading];
    [LZYNetwork requestObjectModelWithTableName:[LZYInterviewModel class] success:^(NSArray *result) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addHeightToCellModel:result];
            self.dataSource.array = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                //计算
                [self.tableView reloadData];
                if (result.count > 0) {
                    [self.tableView endLoading];
                }else{
                    [self.tableView loadNone];
                }
            });
        });
    } failure:^(id result) {
        
        [self.tableView loadError];
    }];
}

- (void)refreshData
{
    [super refreshData];
    [LZYNetwork requestObjectModelWithTableName:[LZYInterviewModel class] success:^(NSArray *result) {
        [self endRefreshData];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self addHeightToCellModel:result];
        self.dataSource.array = result;
        //计算
        [self tableviewRefresh];
        });
    } failure:^(id result) {
        [self endRefreshData];
        
    }];
}

- (void)loadMoreData
{
    [super loadMoreData];
    LZYInterviewModel *model = self.dataSource.lastObject;
    LZYBmobQueryTypeModel *queryModel = [[LZYBmobQueryTypeModel alloc] init];
    queryModel.queryValue = model.updatedAt;
    queryModel.queryKeyName = @"updatedAt";
    queryModel.type = kLessThan;
    [LZYNetwork requestObjectModelWithTableName:[LZYInterviewModel class] conditions:@[queryModel] success:^(NSArray *result) {

            if (result.count == 0) {
                [self noMoreData];
                return;
            }
            [self endLoadMoreData];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addHeightToCellModel:result];
            [self.dataSource addObjectsFromArray:result];
            [self tableviewRefresh];
            });

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
    
    LZYInterviewModel *model = self.dataSource[indexPath.row];
    LZYInterviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"interviewCell" forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    cell.loadMoreContentClick = ^(BOOL isLoadMore){
        model.isLoadMore = !model.isLoadMore;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    [self configeCell:cell model:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYInterviewModel *model = self.dataSource[indexPath.row];
    if (model.isLoadMore) {
     return  model.totalCellHeight;
    }
    
    return model.cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    LZYCommentViewController *v = [[LZYCommentViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}


- (void)configeCell:(LZYInterviewTableViewCell *)cell model:(LZYInterviewModel *)model
{
    if(!model.isWordBreak){
        //优先级改变
        [cell.loadMoreButton setHidden:YES];
        cell.toolBarToInterviewConstraint.priority = 996;
    }
    else{
        [cell.loadMoreButton setHidden:NO];
        cell.toolBarToInterviewConstraint.priority = 998;
    }
    
    if (model.isLoadMore) {
        cell.interviewHeightConstraint.constant = model.cellHeight;
  
        [cell.loadMoreButton setSelected:YES];
    }
    else {
        cell.interviewHeightConstraint.constant = 50;
        [cell.loadMoreButton setSelected:NO];
    }
    
    cell.timeLabel.text = [self.dateFormatter stringFromDate:model.createdAt];
    cell.interviewUserName.text = model.userName;
    cell.companyNameLabel.text = model.companyName;
    cell.interviewContentLabel.text = [NSString stringWithFormat:@"面试过程:%@",model.interviewContent];
    cell.jobTitleLabel.text = model.jobTitle;
    
}

- (void)addHeightToCellModel:(NSArray *)arr
{
    for (LZYInterviewModel *model in arr) {
        if(model.cellHeight <= 0){
            [LZYInterviewTableViewCell cellHeightWithContent:[NSString stringWithFormat:@"面试过程:%@",model.interviewContent] model:model];
        }
    }
    
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
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _dateFormatter;
}
@end
