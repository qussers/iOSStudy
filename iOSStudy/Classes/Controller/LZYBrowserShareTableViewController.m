//
//  LZYShareTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBrowserShareTableViewController.h"
#import "LZYNetwork.h"
#import "LZYShareModel.h"
#import "LZYWebPageModel.h"

@interface LZYBrowserShareTableViewController ()

@end

@implementation LZYBrowserShareTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentTitleTextField.text = self.webPageModel.title;
    self.urlLabel.text = self.webPageModel.url;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)shareItemClick:(id)sender {
    
    LZYShareModel *shareModel = [[LZYShareModel alloc] init];
    shareModel.url = self.webPageModel.url;
    if (self.webPageModel.images && self.webPageModel.images.count > 0) {
        shareModel.urlImageUrl = [self.webPageModel.images firstObject];
    }
    shareModel.content = self.urlDescribeTextView.text;
    shareModel.urlDescribe = self.contentTitleTextField.text;
    
    if ([BmobUser currentUser]) {
        BmobUser *user = [BmobUser currentUser];
        shareModel.userId = user.objectId;
        shareModel.userName = user.username;
        shareModel.userIcon = [user objectForKey:@"userIcon"];
        [shareModel setObject:user forKey:@"user"];
    }

    [self dismissViewControllerAnimated:YES completion:^{
        [shareModel sub_saveInBackground];
    }];
}

- (IBAction)cannelClick:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
