//
//  LZYHelpViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYHelpViewController.h"
#import "LZYNetwork.h"
#import "LZYGlobalDefine.h"
#import "LZYHelpModel.h"
#import "UIImageView+LZYWebCache.h"
#import "LZYOneImageHelpCell.h"
#import "LZYTwoImageHelpCell.h"
#import "LZYMoreImageHelpCell.h"
#import "LZYFourImageHelpCell.h"
#import "YYPhotoGroupView.h"
#import <RongIMKit/RongIMKit.h>

#import "LZYCommentBridgeModel.h"
#import "LZYCommentTool.h"
#import "LZYUserTool.h"
@interface LZYHelpViewController ()<LZYHelpTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LZYHelpViewController


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
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYBaseHelpTableViewCell class]) bundle:nil]  forCellReuseIdentifier:NSStringFromClass([LZYBaseHelpTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYOneImageHelpCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYOneImageHelpCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYTwoImageHelpCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYTwoImageHelpCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYMoreImageHelpCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYMoreImageHelpCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZYFourImageHelpCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LZYFourImageHelpCell class])];
    
    
    [super setUp];
}
- (void)requestData
{
    [self.tableView beginLoading];
    [LZYNetwork requestObjectModelWithTableName:[LZYHelpModel class] success:^(NSArray *result) {
        if (result.count > 0) {
            [self.tableView endLoading];
        }else{
            [self.tableView loadNone];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [LZYBaseHelpTableViewCell addHeightToCellModel:result];
            self.dataSource.array = result;
            [self tableviewRefresh];
        });
      

    } failure:^(id result) {
        
        [self.tableView loadError];
    }];
}

- (void)refreshData
{
    [super refreshData];
    [LZYNetwork requestObjectModelWithTableName:[LZYHelpModel class] success:^(NSArray *result) {
        [self endRefreshData];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [LZYBaseHelpTableViewCell addHeightToCellModel:result];
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
    //取得最后一个元素
    LZYHelpModel *model = self.dataSource.lastObject;
    LZYBmobQueryTypeModel *queryModel = [[LZYBmobQueryTypeModel alloc] init];
    queryModel.queryValue = model.updatedAt;
    queryModel.queryKeyName = @"updatedAt";
    queryModel.type = kLessThan;
    
    [LZYNetwork requestObjectModelWithTableName:[LZYHelpModel class] conditions:@[queryModel] success:^(NSArray *result) {
        if (result.count == 0) {
            [self noMoreData];
            return;
        }
        [self endLoadMoreData];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [LZYBaseHelpTableViewCell addHeightToCellModel:result];
            [self.dataSource addObjectsFromArray:result];
            //计算
            [self tableviewRefresh];
        });
  
    } failure:^(id result) {
         [self endLoadMoreData];
    }];

}

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
    LZYHelpModel *model = self.dataSource[indexPath.row];
    LZYBaseHelpTableViewCell *cell = nil;
    switch (model.images.count) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYBaseHelpTableViewCell class]) forIndexPath:indexPath];
            
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYOneImageHelpCell class]) forIndexPath:indexPath];
        
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYTwoImageHelpCell class]) forIndexPath:indexPath];
            
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYMoreImageHelpCell class]) forIndexPath:indexPath];
            
        }
            break;
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYFourImageHelpCell class]) forIndexPath:indexPath];
            
        }
            break;
            
        default:
             cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZYMoreImageHelpCell class]) forIndexPath:indexPath];
            
            break;
    }
    cell.delegate = self;
    [self configeCell:cell model:model];
    return cell;
}


- (void)configeCell:(LZYBaseHelpTableViewCell *)cell model:(LZYHelpModel *)model
{
    cell.tooBarYCons.constant = model.tooBarYCons;
    for (int i = 0; i < cell.imageViewsContaonerView.subviews.count; i++) {
        UIImageView *subView = [cell.imageViewsContaonerView viewWithTag:(i + 1)];
        if (i < model.images.count) {
            [subView setHidden:NO];
            [subView lzy_setImageWithURL:model.images[i]];
        }else{
            [subView setHidden:YES];
        }
    }
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    cell.timeLabel.text = [dateFormatter stringFromDate:model.createdAt];
    cell.userNaleLabel.text = model.user.username;
    cell.contentLabel.text = model.content;
    cell.helpCommentLabel.text = [NSString stringWithFormat:@"帮助他(%ld)",model.commentCount];
    [cell.userIconImageView lzy_setImageWithURL:[model.user objectForKey:@"userIcon"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZYHelpModel *model = self.dataSource[indexPath.row];
    return model.cellHeight;
}

#pragma mark - LZYBaseHelpCellDelegate

//点击了用户中心
- (void)cellDidClickUser:(LZYBaseHelpTableViewCell *)cell
{
    LZYHelpModel *model = self.dataSource[[self.tableView indexPathForCell:cell].row];
    [LZYUserTool userClickCommentBtnFromViewController:self user:model.user];
    
}

//点击“帮助他”
- (void)cellDidClickHelp:(LZYBaseHelpTableViewCell *)cell
{
    LZYHelpModel *model = self.dataSource[[self.tableView indexPathForCell:cell].row];
    LZYCommentBridgeModel *commentModel = [[LZYCommentBridgeModel alloc] init];
    commentModel.contentObjectId = model.objectId;
    commentModel.commentType = kHelpComment;
    commentModel.pointerObjectName = NSStringFromClass([LZYHelpModel class]);
    [LZYCommentTool userClickCommentBtnFromViewController:self commentBridge:commentModel];
}

//点击了图片
- (void)cell:(LZYBaseHelpTableViewCell *)cell didClickImageWithIndex:(NSInteger)index
{
    //
    LZYHelpModel *model = self.dataSource[[self.tableView indexPathForCell:cell].row];
    UIImageView *fromView = nil;
    NSMutableArray *items = @[].mutableCopy;
    for (NSUInteger i = 0,max = model.images.count;i < max; i++) {
        UIImageView *imageView = [cell.imageViewsContaonerView viewWithTag:i + 1];
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

#pragma mark -

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

@end
