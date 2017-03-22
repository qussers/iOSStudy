//
//  LZYCommentViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/28.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYCommentViewController.h"
#import "LZYCommentTableViewCell.h"
#import "LZYCommentModel.h"
#import "LZYCommentLayoutModel.h"
#import "UIView+NetLoadView.h"
#import "LZYNetwork.h"
#import "LZYCommentBridgeModel.h"
#import "LZYEditHelpViewController.h"
#import "LZYBrowserSearchWebViewController.h"
#import "LZYUserTool.h"
#import "YYPhotoGroupView.h"
@interface LZYCommentViewController ()<UITableViewDelegate,UITableViewDataSource,LZYCommentTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end


@implementation LZYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}


- (void)setup
{
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回复" style:UIBarButtonItemStyleDone target:self action:@selector(editComment)];
}

- (void)requestData
{
    [self.tableView beginLoading];
    LZYBmobQueryTypeModel *model = [[LZYBmobQueryTypeModel alloc] init];
    model.queryKeyName = @"pointerId";
    model.queryValue = self.commentBridge.contentObjectId;
    model.type = kEqual;
    [LZYNetwork requestObjectModelWithTableName:[LZYCommentModel class] conditions:@[model] success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        if ([(NSArray *)result count] == 0) {
            [self.tableView loadNone];
        }
        else{
            [self.tableView endLoading];
        }
        for (LZYCommentModel *model in result) {
            LZYCommentLayoutModel *layoutModel = [[LZYCommentLayoutModel alloc] initWithModel:model];
            [self.dataSource addObject:layoutModel];
        }
        [self.tableView reloadData];
    } failure:^(id result) {
        [self.tableView loadError];
    }];
    
}

- (void)refreshData
{
    LZYBmobQueryTypeModel *model = [[LZYBmobQueryTypeModel alloc] init];
    model.queryKeyName = @"pointerId";
    model.queryValue = self.commentBridge.contentObjectId;
    model.type = kEqual;
    [LZYNetwork requestObjectModelWithTableName:[LZYCommentModel class] conditions:@[model] success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        for (LZYCommentModel *model in result) {
            LZYCommentLayoutModel *layoutModel = [[LZYCommentLayoutModel alloc] initWithModel:model];
            [self.dataSource addObject:layoutModel];
        }
        [self.tableView reloadData];
        [self endRefreshData];
    } failure:^(id result) {
        [self endRefreshData];
        [self.tableView loadError];
    }];
    
}


- (void)editComment
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYEditHelpViewController *editVc = [storyboard instantiateViewControllerWithIdentifier:@"editHelpViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editVc];
    editVc.commentBridge = self.commentBridge;
    [self presentViewController:nav animated:YES completion:nil];
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
    LZYCommentTableViewCell *cell  = [tableView  dequeueReusableCellWithIdentifier:NSStringFromClass([LZYCommentTableViewCell class])];
    if (!cell) {
        cell = [[LZYCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LZYCommentTableViewCell class])];
        cell.delegate = self;
    }
    [cell configeCellWithLayoutModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    LZYCommentLayoutModel *layoutModel = self.dataSource[indexPath.row];
    return  layoutModel.cellFrame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    //跳转到对应的编辑页面

}

#pragma mark - LZYCommentTableViewCellDelegate

- (void)cell:(LZYCommentTableViewCell *)cell didClickWebUrl:(NSString *)url
{
    LZYBrowserSearchWebViewController *v = [[LZYBrowserSearchWebViewController alloc] init];
    v.webUrl = url;
    [self.navigationController pushViewController:v animated:YES];
}

- (void)cellDidClickReword:(LZYCommentTableViewCell *)cell
{

}

- (void)cellDidClickUserIcon:(LZYCommentTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LZYCommentLayoutModel *layoutModel = self.dataSource[indexPath.row];
    [LZYUserTool userClickCommentBtnFromViewController:self user:layoutModel.model.user];
    
}

- (void)cell:(LZYCommentTableViewCell *)cell didClickImageWithIndex:(NSInteger)index
{

    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LZYCommentLayoutModel *layoutModel = self.dataSource[indexPath.row];
    UIImageView *fromView = nil;
    NSMutableArray *items = @[].mutableCopy;
    for (NSUInteger i = 0,max = layoutModel.model.images.count;i < max; i++) {
        UIImageView *imageView = [cell.imagesScrollView viewWithTag:i + 1];
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imageView;
        //item.largeImageURL = [NSURL URLWithString:model.images[i]];
        [items addObject:item];
        if (i == index) {
            fromView = imageView;
        }
    }
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [v presentFromImageView:fromView toContainer:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES completion:^{
        
    }];

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
