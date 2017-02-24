//
//  LZYSMSTimerManager.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSMSTimerManager.h"

@implementation LZYSMSTimerManager

 static LZYSMSTimerManager *manager = nil;

+ (instancetype)defaultSMSTimeManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LZYSMSTimerManager alloc] init];
        manager.totalTime = 60;
        manager.consumeTime = 0;
        manager.leftTime = 0;
    });
    
    return manager;
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (manager == nil) {
        manager = [[super  allocWithZone:zone] init];
    }
    
    return manager;
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return self;
}


- (void)sendSMSStart
{
    if (self.leftTime > 0 ) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0;  i < self.totalTime; i++) {
            [NSThread sleepForTimeInterval:1.0f];
            self.consumeTime++;
            self.leftTime = self.totalTime - self.consumeTime;
            [[NSNotificationCenter defaultCenter] postNotificationName:LZYSENDSMSLEDTTIMECHANGEDNOTICE object:@(self.leftTime) userInfo:nil];
            if (self.leftTime <= 0 || self.consumeTime >= self.totalTime) {
                self.leftTime = self.totalTime;
                self.consumeTime = 0;
                [[NSNotificationCenter defaultCenter] postNotificationName:LZYSENDSMSLEFTTIMEZERONOTIVE object:nil userInfo:nil];
                return ;
            }
        
        }
  
    });

}


@end
