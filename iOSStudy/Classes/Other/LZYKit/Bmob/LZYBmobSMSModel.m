//
//  LZYBmobSMSModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBmobSMSModel.h"
#import "LZYGlobalDefine.h"



@implementation LZYBmobSMSModel

- (void)setType:(smsType)type
{
   
    _type = type;
    switch (type) {
    case kSMSLogin:
        _smsTypeName = @"login";
        break;
    case kSMSRegister:
        _smsTypeName = @"register";
        break;
    case kSMSforgetPassword:
        _smsTypeName = @"忘记密码";
        break;
    default:
        break;
    }
}
@end
