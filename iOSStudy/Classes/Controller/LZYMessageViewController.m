//
//  LZYMessageViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYMessageViewController.h"

@interface LZYMessageViewController ()

@end

@implementation LZYMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

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

@end
