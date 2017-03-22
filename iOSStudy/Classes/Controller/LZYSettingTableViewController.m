//
//  LZYSettingTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSettingTableViewController.h"
#import <BmobSDK/Bmob.h>
@interface LZYSettingTableViewController ()

@end

@implementation LZYSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)logoutClick:(id)sender {
    if ([BmobUser currentUser]) {
        [BmobUser logout];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
