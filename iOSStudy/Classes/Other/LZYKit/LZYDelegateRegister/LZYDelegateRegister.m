//
//  LZYDelegateRegister.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYDelegateRegister.h"
#import "LZYGlobalDefine.h"
#import <BmobSDK/Bmob.h>
@implementation LZYDelegateRegister
+ (void)registerServe
{
    [self registerBMOB];
}

//注册比目后端云服务
+ (void)registerBMOB
{
    [Bmob registerWithAppKey:LZYBMOBKEY];
}
@end
