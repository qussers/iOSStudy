//
//  LZYResetPasswordTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/24.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYResetPasswordTableViewController.h"
#import "UITextField+LZYAdd.h"
#import "LZYNetwork.h"

#import "MBProgressHUD+LZYAdd.h"
@interface LZYResetPasswordTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *password2TextField;



@end

@implementation LZYResetPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)complete:(UIBarButtonItem *)sender {
    
    if (!([self.passwordTextField filterPassword] && [self.password2TextField filterPassword2WithPassword:self.passwordTextField])) {
        return;
    }
    
    [LZYNetwork resetPasswordWithMobilePhoneNumber:nil SMSCode:self.smsCode newPassword:self.passwordTextField.text result:^(BOOL isSuccess, id error) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"密码重置成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
        
            [MBProgressHUD showSuccess:@"密码重置失败"];
        }
        
    }];
    
    
}


@end
