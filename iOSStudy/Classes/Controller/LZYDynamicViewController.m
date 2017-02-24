//
//  LZYDynamicViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYDynamicViewController.h"
#import "LZYGlobalDefine.h"
#import "LZYDynamicTitlesView.h"
#import "LZYInviteJobViewController.h"
#import "LZYInterviewViewController.h"

//编辑页面
#import "LZYEditInterviewViewController.h"

#define LZYDynamicTitles @[@"面试",@"求助",@"招聘",@"吐槽"]
@interface LZYDynamicViewController ()<LZYDynamicTitlesViewDelegate,UIScrollViewDelegate>

//标题视图
@property (nonatomic, strong) LZYDynamicTitlesView *dynamicTitleView;

//区域视图
@property (nonatomic, strong) UIScrollView *contentScrollView;

//模块数量
@property (nonatomic, assign) NSInteger subCount;


@property (nonatomic, strong) LZYInviteJobViewController *inviteJobViewController;

@property (nonatomic, strong) LZYInterviewViewController *interviewController;


@end

@implementation LZYDynamicViewController

CGFloat dynamicHeight = 30;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
    [self createContentView];
    [self createSubControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//针对首页视图显示和隐藏tabbar设置
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)setup
{
    self.subCount = [LZYDynamicTitles count];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)createContentView
{
    //创建标题栏
    _dynamicTitleView = [[LZYDynamicTitlesView alloc] initWithFrame:CGRectMake(0, 64, LZYSCREEN_WIDTH, dynamicHeight)];
    _dynamicTitleView.delegate = self;
    _dynamicTitleView.titles = LZYDynamicTitles;
    [self.view addSubview:_dynamicTitleView];
    
    //创建滚动视图
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, dynamicHeight + 64, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64)];
    _contentScrollView.contentSize = CGSizeMake(LZYSCREEN_WIDTH * self.subCount, _contentScrollView.frame.size.height);
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.bounces = YES;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
}

- (void)createSubControllers
{
    
    UIStoryboard *storyboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //招聘
    _inviteJobViewController = [storyboard instantiateViewControllerWithIdentifier:@"inviteJobViewController"];
    [self addChildViewController:_inviteJobViewController];
    _inviteJobViewController.view.frame = CGRectMake(0, 0, LZYSCREEN_WIDTH, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:self.inviteJobViewController.view];
    
    //面试
    _interviewController = [storyboard instantiateViewControllerWithIdentifier:@"interviewController"];
    [self addChildViewController:_interviewController];
    _interviewController.view.frame = CGRectMake(LZYSCREEN_WIDTH, 0, LZYSCREEN_WIDTH, self.contentScrollView.frame.size.height);

    [self.contentScrollView addSubview:self.interviewController.view];
    
}

#pragma mark - LZYDynamicTitlesViewDelegate
- (void)dynamicTitleView:(LZYDynamicTitlesView *)dynamicTitleView didSelected:(NSInteger)index
{
    NSLog(@"%ld",index);
}


- (IBAction)editButtonClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYEditInterviewViewController *v = [storyboard instantiateViewControllerWithIdentifier:@"editInterviewController"];
    [self.navigationController pushViewController:v animated:YES];
    
}



@end
