//
//  LZYForgetPasswordTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/24.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYForgetPasswordTableViewController.h"
#import "LZYNetwork.h"
#import "MBProgressHUD+LZYAdd.h"
#import "LZYSMSTimerManager.h"
#import "LZYBmobSMSModel.h"
#import "UITextField+LZYAdd.h"
#import "LZYResetPasswordTableViewController.h"
@interface LZYForgetPasswordTableViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *smsTextField;

@property (weak, nonatomic) IBOutlet UIButton *smsButton;

//验证码验证是否成功
@property (atomic, assign) BOOL isVerifityOk;

@end

@implementation LZYForgetPasswordTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    //验证码通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smsLeftTimeNotice:) name:LZYSENDSMSLEDTTIMECHANGEDNOTICE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smsEndNotice:) name:LZYSENDSMSLEFTTIMEZERONOTIVE object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mobilePhoneNumberTextField resignFirstResponder];
    [self.smsTextField resignFirstResponder];
}


- (IBAction)smsButtonClick:(id)sender {
    
    if (![self.mobilePhoneNumberTextField filterMobilePhoneNumber]) {
        return;
    }
    
    if([LZYSMSTimerManager defaultSMSTimeManager].isAllowRequestSMS){
        LZYBmobSMSModel *smsModel = [[LZYBmobSMSModel alloc] init];
        smsModel.type = kSMSforgetPassword;
        [LZYNetwork requestSMSWithMobilePhoneNumber:self.mobilePhoneNumberTextField.text SMSModel:smsModel success:^(NSInteger msgId) {
            [[LZYSMSTimerManager defaultSMSTimeManager] sendSMSStart];
        } failure:^(id result) {
            [MBProgressHUD showError:@"验证码发送失败"];
        }];
    }
    [[LZYSMSTimerManager defaultSMSTimeManager] sendSMSStart];
}

- (void)smsLeftTimeNotice:(NSNotification *)notification
{
    //主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger leftTime = [[notification object] integerValue];
        [self.smsButton setTitle:[NSString stringWithFormat:@"已发送(%ld)",leftTime] forState:UIControlStateNormal];
    });
    
}

- (void)smsEndNotice:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.smsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    });
}


- (IBAction)nextItemClick:(UIBarButtonItem *)sender {

    if (!self.isVerifityOk) {
        
        [MBProgressHUD showError:@"输入信息有误"];
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYResetPasswordTableViewController *v = [storyboard instantiateViewControllerWithIdentifier:@"resetPasswordController"];
    v.smsCode = self.smsTextField.text;
    [self.navigationController pushViewController:v animated:YES];
}


- (IBAction)editChange:(UITextField *)sender {
    
    if (self.mobilePhoneNumberTextField.text.length <= 10) {
        return;
    }
    [LZYNetwork verfitySMSWithMobilePhoneNumber:self.mobilePhoneNumberTextField.text SMSCode:self.smsTextField.text result:^(BOOL isSuccess, id error) {
        self.isVerifityOk = isSuccess;
    }];
}


#pragma mark - 析构

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];


}

@end
