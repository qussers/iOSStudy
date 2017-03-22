//
//  LZYExDetailViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailViewController.h"
#import "LZYGlobalDefine.h"
#import "LZYExSubmitViewController.h"
#import "LZYExDetailCollectionView.h"
#import "LZYExParseCollectionView.h"
#import "LZYExDetailBottomView.h"
#import "UIView+Xib.h"
#import "LZYCommentTool.h"
@interface LZYExDetailViewController ()

@property (nonatomic, strong) LZYExDetailCollectionView *collectionView;

@property (nonatomic, strong) LZYExParseCollectionView *parse;

@property (nonatomic, strong) LZYExDetailBottomView *bottomView;

@end

@implementation LZYExDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addUI];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUI
{
    self.collectionView.collectionView.frame = CGRectMake(0, 64, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64);
    [self.view addSubview:self.collectionView.collectionView];
}

- (void)requestData
{
    [[self.collectionView.fetchDataCommand execute:nil] subscribeError:^(NSError * _Nullable error) {
        NSLog(@"出错😝辣");
    } completed:^{
        NSLog(@"数据没有问题哦~~哦😯");
    }];
}


#pragma mark - 展示解析模式
- (void)showParseViewWithIndex:(NSInteger)index
{
    CGRect oldReact = self.collectionView.collectionView.frame;
    //添加底部编辑
    self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 49, CGRectGetWidth(self.view.frame), 49);
    [self.view addSubview:self.bottomView];
    self.parse.collectionView.frame = CGRectMake(oldReact.origin.x, oldReact.origin.y, oldReact.size.width, oldReact.size.height - 49);
    [self.collectionView.collectionView removeFromSuperview];
    [self.view addSubview:self.parse.collectionView];
    //刷新
    [self.parse.parseDataCommand execute:nil];
}

- (void)showOverViewWithIndex:(NSInteger)index
{
    [self.collectionView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - 跳转逻辑

- (void)pushToSubmitWithData:(NSArray *)data
{
    LZYExSubmitViewController *submitVC = [[LZYExSubmitViewController alloc] initWithData:data];
    RACSubject *subject = [RACSubject subject];
    RACSubject *overSubject= [RACSubject subject];
    submitVC.parseClickSubject = subject;
    submitVC.overViewClickSubject = overSubject;
    [self.navigationController pushViewController:submitVC animated:YES];
    
    @weakify(self);
    [subject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self showParseViewWithIndex:[x integerValue]];
    }];
    [overSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self showOverViewWithIndex:[x integerValue]];
    }];
}

//进行讨论编辑界面
- (void)presentToEditViewController
{
    
    LZYCommentBridgeModel *brigde = [[LZYCommentBridgeModel alloc] init];
    brigde.contentObjectId = self.parse.currentModel.objectId;
    brigde.pointerObjectName = NSStringFromClass([LZYExDetailModel class]);
    [LZYCommentTool userClickEditCommentBtnFromViewController:self commentBridge:brigde];
}


#pragma mark - lazy

//基础答题模式
- (LZYExDetailCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [LZYExDetailCollectionView instanceWithViewModel:[LZYExDetailViewModel viewModelWithObjectId:self.objectId]];
        _collectionView.allOptionCompletedSubject = [RACSubject subject];
        @weakify(self);
        [_collectionView.allOptionCompletedSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self pushToSubmitWithData:x];
        }];
    }
    return _collectionView;
}

- (LZYExParseCollectionView *)parse
{
    if (!_parse) {
        _parse = [LZYExParseCollectionView instanceWithViewModel:[LZYExParseViewModel instanceWithViewModel:self.collectionView.viewModel]];
    }
    return _parse;
}


- (void)dealloc
{
    NSLog(@"我销毁了😯");
}

#pragma mark - lazy
- (LZYExDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = (LZYExDetailBottomView *)[UIView loadViewWithXibName:@"LZYExDetailBottomView"];
        @weakify(self);
        [[_bottomView.titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            //加入讨论按钮
            [self presentToEditViewController];
        }];
    }
    return _bottomView;
}



@end
