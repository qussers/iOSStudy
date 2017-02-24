//
//  LZYTabBarViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYTabBarViewController.h"
#import "LZYWaveView.h"
#import "LZYGlobalDefine.h"
#import "UIColor+LZYAdd.h"
@interface LZYTabBarViewController ()

@end

@implementation LZYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    LZYWaveView *waveView = [[LZYWaveView alloc] initWithFrame:CGRectMake(0, 0, LZYSCREEN_WIDTH, 49)];
    waveView.waveColor = [UIColor colorWithHexString:MainColor];
    waveView.backgroundWaveColor = [UIColor colorWithHexString:MainColor];
    [waveView startWaveAnimation];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] insertSubview:waveView atIndex:0];

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
