//
//  UITextField+LZYAdd.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/24.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LZYAdd)

//短信验证码合法性
- (BOOL)filterSMSCode;

//密码合法性
- (BOOL)filterPassword;

//电话号码合法性
- (BOOL)filterMobilePhoneNumber;

//重复密码合法性
- (BOOL)filterPassword2WithPassword:(UITextField *)passwordTextField;

@end
