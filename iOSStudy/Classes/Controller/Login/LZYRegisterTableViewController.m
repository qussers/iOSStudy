//
//  LZYRegisterTableViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYRegisterTableViewController.h"
#import "MBProgressHUD+LZYAdd.h"
#import "LZYNetwork.h"
#import "LZYSMSTimerManager.h"
#import "LZYBmobSMSModel.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface LZYRegisterTableViewController ()

@end

@implementation LZYRegisterTableViewController

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



- (IBAction)smsButtonClick:(id)sender {
    
    
    if (self.mobilePhoneNumberTextField.text <= 0) {
        [MBProgressHUD showError:@"账户不能为空"];
        return;
    }
    if ([LZYSMSTimerManager defaultSMSTimeManager].leftTime == 0) {
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
    isOk =  [self filterMobilePhoneNumber] && [self filterSMSCode] && [self filterPassword] && [self filterPassword2];
    if (!isOk) {
        return;
    }
    
    [MBProgressHUD showError:@"正在注册..."];
    [LZYNetwork registerWithMobilPhoneNumber:self.mobilePhoneNumberTextField.text SMSCode:self.smsTextField.text password:self.passwordTextField.text success:^(id user) {
        [MBProgressHUD hideHUD];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(id result) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"注册失败..."];
    }];
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

#pragma mark - filter

- (BOOL)filterMobilePhoneNumber
{
    if (self.mobilePhoneNumberTextField.text.length <= 0) {
        [MBProgressHUD showError:@"手机号码为空"];
        return NO;
    }
    return YES;
}

- (BOOL)filterSMSCode
{
    if (self.smsTextField.text.length <= 0) {
        [MBProgressHUD showError:@"验证码为空"];
        return NO;
    }
    return YES;
}

- (BOOL)filterPassword
{
    if (self.passwordTextField.text.length < 6 ) {
        [MBProgressHUD showError:@"密码太短"];
        return NO;
    }
    return YES;
}

- (BOOL)filterPassword2
{
    if (self.passwordTextField2.text.length == 0 ) {
        [MBProgressHUD showError:@"重复密码为空"];
        return NO;
    }
    
    if (![self.passwordTextField2.text isEqualToString:self.passwordTextField.text]) {
        [MBProgressHUD showError:@"密码不一致"];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - 析构
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
