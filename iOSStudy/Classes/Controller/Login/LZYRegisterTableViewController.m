//
//  LZYRegisterTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYRegisterTableViewController.h"
#import "LZYGlobalDefine.h"
#import "LZYNetwork.h"
#import "LZYSMSTimerManager.h"
#import "LZYBmobSMSModel.h"
#import "UITextField+LZYAdd.h"
#import "MBProgressHUD+LZYAdd.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "LZYRongConnectHelper.h"
@interface LZYRegisterTableViewController ()

@end

@implementation LZYRegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    //验证码通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smsLeftTimeNotice:) name:LZYSENDSMSLEDTTIMECHANGEDNOTICE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smsEndNotice:) name:LZYSENDSMSLEFTTIMEZERONOTIVE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSuccess) name:LZYNOTICE_LOGINSUCCESS  object:nil];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)smsButtonClick:(id)sender {
    
    if (![self.mobilePhoneNumberTextField filterMobilePhoneNumber]) {
        return;
    }
    if ([LZYSMSTimerManager defaultSMSTimeManager].isAllowRequestSMS) {
        //发送验证码计时
        LZYBmobSMSModel *smsModel = [[LZYBmobSMSModel alloc] init];
        smsModel.type = kSMSLogin;
        [LZYNetwork requestSMSWithMobilePhoneNumber:self.mobilePhoneNumberTextField.text SMSModel:smsModel success:^(NSInteger msgId) {
            [[LZYSMSTimerManager defaultSMSTimeManager] sendSMSStart];
            [MBProgressHUD showSuccess:@"已发送..."];
        } failure:^(id result) {
            NSError *er = (NSError *)result;
            [MBProgressHUD showError:[er.userInfo objectForKey:@"error"]];
        }];
    }
}

- (IBAction)registerButtonClick:(id)sender {
    
    BOOL isOk = YES;
    isOk =  [self.mobilePhoneNumberTextField filterMobilePhoneNumber] && [self.smsTextField filterSMSCode] && [self.passwordTextField filterPassword] && [self.passwordTextField2 filterPassword2WithPassword:self.passwordTextField];
    if (!isOk) {
        return;
    }
    
    [MBProgressHUD showError:@"正在注册..."];
    [LZYNetwork registerWithMobilPhoneNumber:self.mobilePhoneNumberTextField.text SMSCode:self.smsTextField.text password:self.passwordTextField.text success:^(id user) {
        [MBProgressHUD hideHUD];
        [LZYRongConnectHelper connectToRongCloud];
    } failure:^(id result) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"注册失败..."];
    }];
}


- (void)dismissSuccess
{
    [self dismissViewControllerAnimated:YES completion:nil];
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



#pragma mark - 析构
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
