//
//  LZYDelegateRegister.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYDelegateRegister.h"
#import "LZYGlobalDefine.h"
#import "LZYRongConnectHelper.h"
#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
@implementation LZYDelegateRegister

+ (void)registerServe
{
    [self registerBMOB];
    [self registerRongCloud];
}


//注册比目后端云服务
+ (void)registerBMOB
{
  [Bmob registerWithAppKey:LZYBMOBKEY];
}

//注册融云服务
+ (void)registerRongCloud
{
    [[RCIM sharedRCIM] initWithAppKey:LZYRONGCLOUDKEY];
    [LZYRongConnectHelper connectToRongCloud];
}

@end
