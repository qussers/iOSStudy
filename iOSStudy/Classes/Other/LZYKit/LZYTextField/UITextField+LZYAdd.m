//
//  UITextField+LZYAdd.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/24.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "UITextField+LZYAdd.h"
#import "MBProgressHUD+LZYAdd.h"
@implementation UITextField (LZYAdd)

- (BOOL)filterMobilePhoneNumber
{
    if (self.text.length <= 0) {
        [MBProgressHUD showError:@"手机号码为空"];
        return NO;
    }
    return YES;
}

- (BOOL)filterSMSCode
{
    if (self.text.length <= 0) {
        [MBProgressHUD showError:@"验证码为空"];
        return NO;
    }
    return YES;
}

- (BOOL)filterPassword
{
    if (self.text.length < 6 ) {
        [MBProgressHUD showError:@"密码太短"];
        return NO;
    }
    return YES;
}

- (BOOL)filterPassword2WithPassword:(UITextField *)passwordTextField
{
    if (self.text.length == 0 ) {
        [MBProgressHUD showError:@"重复密码为空"];
        return NO;
    }
    
    if (![self.text isEqualToString:passwordTextField.text]) {
        [MBProgressHUD showError:@"密码不一致"];
        
        return NO;
    }
    
    return YES;
}
@end
