//
//  LZYSMSTimerManager.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LZYSENDSMSLEDTTIMECHANGEDNOTICE @"LZYSendSMSLeftTimeChangedNotice"
#define LZYSENDSMSLEFTTIMEZERONOTIVE @"LZYSendSMSLeftTimeZeroNotice"
@interface LZYSMSTimerManager : NSObject<NSCopying,NSMutableCopying>

+ (instancetype)defaultSMSTimeManager;

//是否允许发送验证码
@property (nonatomic, assign) BOOL isAllowRequestSMS;

//计时剩余时间
@property (nonatomic, assign) NSInteger leftTime;

//计时消耗
@property (nonatomic, assign) NSInteger consumeTime;

//默认60秒
@property (nonatomic, assign) NSInteger totalTime;

//发送验证码
- (void)sendSMSStart;

@end
