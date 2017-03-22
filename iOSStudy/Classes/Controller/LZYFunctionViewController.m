//
//  LZYFunctionViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/1.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYFunctionViewController.h"
#import "LZYGlobalDefine.h"
#import "LZYDynamicTitlesView.h"
#import "LZYInviteJobViewController.h"
#import "LZYInterviewViewController.h"
#import "LZYHelpViewController.h"
#import "LZYShareTableViewController.h"


#define LZYDynamicTitles @[@"求助",@"分享",@"面试",@"招聘"]
@interface LZYFunctionViewController ()<LZYDynamicTitlesViewDelegate,UIScrollViewDelegate>
//标题视图
@property (nonatomic, strong) LZYDynamicTitlesView *dynamicTitleView;

//区域视图
@property (nonatomic, strong) UIScrollView *contentScrollView;

//模块数量
@property (nonatomic, assign) NSInteger subCount;

@property (nonatomic, strong) LZYInviteJobViewController *inviteJobViewController;

@property (nonatomic, strong) LZYInterviewViewController *interviewController;

@property (nonatomic, strong) LZYHelpViewController *helpViewController;

@property (nonatomic, strong) LZYShareTableViewController *shareViewController;

@end

@implementation LZYFunctionViewController

CGFloat dynamicHeight = 30;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self createContentView];
    [self createSubControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, dynamicHeight + 64, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64 - 49 - dynamicHeight)];
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
    [self changeToPageWithIndex:0];
}


//切换
- (void)changeToPageWithIndex:(NSInteger)index
{
    UIStoryboard *storyboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (index) {
        case 0:
        {
            if (![self.contentScrollView.subviews containsObject:self.helpViewController.view]) {
                //帮助
                _helpViewController = [storyboard instantiateViewControllerWithIdentifier:@"helpViewController"];
                [self addChildViewController:_helpViewController];
                _helpViewController.view.frame = CGRectMake(0, 0, LZYSCREEN_WIDTH, self.contentScrollView.frame.size.height);
                [self.contentScrollView addSubview:self.helpViewController.view];
            }
        }
            break;
        case 1:
        {
            if (![self.contentScrollView.subviews containsObject:self.shareViewController.view]) {
                
                //分享
                _shareViewController = [storyboard instantiateViewControllerWithIdentifier:@"shareViewController"];
                [self addChildViewController:_shareViewController];
                _shareViewController.view.frame = CGRectMake(LZYSCREEN_WIDTH * 1, 0, LZYSCREEN_WIDTH, self.contentScrollView.frame.size.height);
                [self.contentScrollView addSubview:self.shareViewController.view];
            }
            
        }
            break;
        case 2:
        {
            if (![self.contentScrollView.subviews containsObject:self.interviewController.view]) {
                //面试
                _interviewController = [storyboard instantiateViewControllerWithIdentifier:@"interviewController"];
                [self addChildViewController:_interviewController];
                _interviewController.view.frame = CGRectMake(LZYSCREEN_WIDTH * 2, 0, LZYSCREEN_WIDTH, self.contentScrollView.frame.size.height);
                [self.contentScrollView addSubview:self.interviewController.view];
            }
        }
            break;
        case 3:
        {
            if (![self.contentScrollView.subviews containsObject:self.inviteJobViewController.view]) {
                //招聘
                _inviteJobViewController = [storyboard instantiateViewControllerWithIdentifier:@"inviteJobViewController"];
                [self addChildViewController:_inviteJobViewController];
                _inviteJobViewController.view.frame = CGRectMake(LZYSCREEN_WIDTH * 3, 0, LZYSCREEN_WIDTH, self.contentScrollView.frame.size.height);
                [self.contentScrollView addSubview:self.inviteJobViewController.view];
            }
        }
            break;
            
        default:
            break;
    }
    
    [self.contentScrollView setContentOffset:CGPointMake(LZYSCREEN_WIDTH * index, self.contentScrollView.contentOffset.y) animated:YES];
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / LZYSCREEN_WIDTH;
    [self changeToPageWithIndex:index];
    if (index >= 0 && index <= 3) {
        [self.dynamicTitleView scrollToIndex:index];
    }
}


#pragma mark - LZYDynamicTitlesViewDelegate
- (void)dynamicTitleView:(LZYDynamicTitlesView *)dynamicTitleView didSelected:(NSInteger)index
{
    [self changeToPageWithIndex:index];
}


@end
