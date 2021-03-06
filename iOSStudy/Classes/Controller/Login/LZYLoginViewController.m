//
//  LZYloginViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYLoginViewController.h"
#import "LZYGlobalDefine.h"
#import "LZYNetwork.h"

#import "UIImage+LZYAdd.h"
#import "UITextField+LZYAdd.h"
#import "MBProgressHUD+LZYAdd.h"
#import "LZYSMSTimerManager.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import "LZYRongConnectHelper.h"
@interface LZYLoginViewController ()<UIScrollViewDelegate>

@end

@implementation LZYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setNotification];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.backgroundImageView.image = [self.backgroundImageView.image blurryImageWithLevel:0.08];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss:) name:LZYNOTICE_LOGINSUCCESS  object:nil];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tableView setContentOffset:CGPointMake(0, 0)];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setNotification
{
    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //验证码通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smsLeftTimeNotice:) name:LZYSENDSMSLEDTTIMECHANGEDNOTICE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smsEndNotice:) name:LZYSENDSMSLEFTTIMEZERONOTIVE object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)notice
{
    [self.tableView setContentOffset:CGPointMake(0, CGRectGetMaxY(self.loginButton.frame))];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float newx = 0;
    static float oldIx = 0;
    newx= scrollView.contentOffset.y;
    if (newx != oldIx ) {
        if (newx < oldIx) {
            [self.passwordTextField resignFirstResponder];
            [self.accountTextField resignFirstResponder];
        }
        oldIx = newx;
    }
}


//点击验证码
- (IBAction)verfityButtonClick:(UIButton *)sender {
    if (![self.accountTextField filterMobilePhoneNumber]) {
        return;
    }
    
    if ([LZYSMSTimerManager defaultSMSTimeManager].isAllowRequestSMS) {
        //发送验证码计时
        LZYBmobSMSModel *smsModel = [[LZYBmobSMSModel alloc] init];
        smsModel.type = kSMSLogin;
        [LZYNetwork requestSMSWithMobilePhoneNumber:self.accountTextField.text SMSModel:smsModel success:^(NSInteger msgId) {
            [[LZYSMSTimerManager defaultSMSTimeManager] sendSMSStart];
            [MBProgressHUD showSuccess:@"已发送..."];
        } failure:^(id result) {
            NSError *er = (NSError *)result;
            [MBProgressHUD showError:[er.userInfo objectForKey:@"error"]];
        }];
    }
    
}

- (void)smsLeftTimeNotice:(NSNotification *)notification
{
    //主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger leftTime = [[notification object] integerValue];
        [self.vertifyButton setTitle:[NSString stringWithFormat:@"已发送(%ld)",leftTime] forState:UIControlStateNormal];
    });

}

- (void)smsEndNotice:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
          [self.vertifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    });
}

- (IBAction)loginButtonClick:(id)sender {

    if (!([self.accountTextField filterMobilePhoneNumber] && [self.passwordTextField filterPassword])) {
        return;
    }
    //账号密码登录
    if (self.vertifyButton.hidden) {
        [MBProgressHUD showMessage:@"登录中..."];
        [LZYNetwork loginWithAccount:self.accountTextField.text password:self.passwordTextField.text success:^(id user) {
            [LZYRongConnectHelper connectToRongCloud];
             [MBProgressHUD hideHUD];
        } failure:^(id result) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"登录失败"];
        }];
    }
    else{
        //短信验证码注册或者登录
        [MBProgressHUD showMessage:@"登录中..."];
        [LZYNetwork registerAndLoginWithMobilePhoneNumber:self.accountTextField.text SMSCode:self.passwordTextField.text success:^(id user) {

            [LZYRongConnectHelper connectToRongCloud];
            [MBProgressHUD hideHUD];
        } failure:^(id result) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"登录失败"];
        }];
    }

    
}

- (IBAction)forgetPassword:(id)sender {
    
    
    
}


- (IBAction)registerAccountClick:(id)sender {
    
    
}


- (IBAction)weixinLogin:(id)sender {
   
    
    
}

- (IBAction)qqLogin:(id)sender {
    
    
    
}
- (IBAction)weiboLogin:(id)sender {
    
    
}

- (IBAction)smsLogin:(id)sender {
    
    if ([self.useSMSLabel.text containsString:@"验证码"]) {
        self.useSMSLabel.text = @"使用账号密码登录";
        self.passwordLabel.text = @"验证码";
        [self.vertifyButton setHidden:NO];
    }
    else{
        self.useSMSLabel.text = @"使用短信验证码登录";
        self.passwordLabel.text = @"密    码";
        [self.vertifyButton setHidden:YES];
    }
    
}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LZYSCREEN_HEIGHT;
}

#pragma mark - 

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
