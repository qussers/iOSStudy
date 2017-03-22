//
//  LZYBrowserSaveTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBrowserSaveTableViewController.h"
#import "LZYWebPageModel.h"
@interface LZYBrowserSaveTableViewController ()

@end

@implementation LZYBrowserSaveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.titleTextField.text = self.webPageModel.title;
    self.urlLabel.text = self.webPageModel.url;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveItemClick:(UIBarButtonItem *)sender {

    self.webPageModel.title = self.describeTextView.text;
    self.webPageModel.describe = self.titleTextField.text;
    //self.webPageModel.tags = self.tagTextField.text;
    
    if ([BmobUser currentUser]) {
        BmobUser *user = [BmobUser currentUser];
        self.webPageModel.userIcon = [user objectForKey:@"userIcon"];
        self.webPageModel.userName = user.username;
        self.webPageModel.userId = user.objectId;
        self.webPageModel.user = user;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.webPageModel sub_saveInBackground];
    }];
}


- (IBAction)cancelClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
