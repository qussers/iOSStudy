//
//  LZYSecondSubjectTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSecondSubjectTableViewController.h"
#import "LZYSecondSubjectTableViewCell.h"
#import "LZYNetwork.h"
#import "LZYSecondSubjectModel.h"
#import "LZYSubjectContentViewController.h"
@interface LZYSecondSubjectTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LZYSecondSubjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData
{
    [LZYNetwork requestSubjectContentWithSubjectTag:self.subjectTag success:^(NSArray *result) {
        if (result) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result];
            [self.tableView reloadData];
        }
    } failure:^(id result) {
        
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYSecondSubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondSubjectCell" forIndexPath:indexPath];
    
    LZYSecondSubjectModel *model = self.dataSource[indexPath.row];
    cell.subTitleLabel.text = model.subjectTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYSecondSubjectModel *model = self.dataSource[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYSubjectContentViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"subjectContentViewController"];
    vc.webUrl = model.answerUrl;
    [self.navigationController pushViewController:vc animated:YES];
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
