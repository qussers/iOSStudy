//
//  LZYTestEveryDayViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/19.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYTestEveryDayViewController.h"

@interface LZYTestEveryDayViewController ()<LZYCardPushViewDataSource>

@end

@implementation LZYTestEveryDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.grectm
    

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
    UILabel *label = [[UILabel alloc] initWithFrame:cardPushView.bounds];
    label.text = [NSString stringWithFormat:@"%ld",pageIndex];
    label.backgroundColor = [UIColor whiteColor];
    return label;
}
@end
