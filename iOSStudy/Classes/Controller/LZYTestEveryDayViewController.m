//
//  LZYTestEveryDayViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/19.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYTestEveryDayViewController.h"
#import "UIView+Xib.h"
#import "LZYCardPageView.h"
@interface LZYTestEveryDayViewController ()<LZYCardPushViewDataSource>

@end

@implementation LZYTestEveryDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.grectm
    
    [self.view bringSubviewToFront:self.cardView];
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


#pragma mark -

- (NSInteger)numberOfCardsWithPushView:(LZYCardPushView *)cardPushView
{
    return 8;
}

- (UIView *)cardPushView:(LZYCardPushView *)cardPushView index:(NSInteger)pageIndex
{
    LZYCardPageView *cardView = (LZYCardPageView *)[UIView loadViewWithXibName:@"LZYCardPageView"];
    
    return cardView;
}
@end
