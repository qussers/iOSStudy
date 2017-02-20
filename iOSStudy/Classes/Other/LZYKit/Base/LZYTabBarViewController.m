//
//  LZYTabBarViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYTabBarViewController.h"
#import "SYWaterAnimationView.h"
#import "LZYGlobalDefine.h"
#import "UIColor+LZYAdd.h"
@interface LZYTabBarViewController ()

@end

@implementation LZYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SYWaterAnimationView *waterView = [[SYWaterAnimationView alloc] initWithFrame:CGRectMake(0, 0, LZYSCREEN_WIDTH + 2, 49) waveColor:[UIColor colorWithRed:36/255.0 green:215/255.0 blue:220/255.0 alpha:0.5] waterColor:[UIColor colorWithRed:36/255.0 green:215/255.0 blue:220/255.0 alpha:0.8]];
    waterView.waveSpeed = 0.01;
    waterView.waveCurrentHeight = 10;
    waterView.waveAmplitude = 4;

    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] insertSubview:waterView atIndex:0];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
