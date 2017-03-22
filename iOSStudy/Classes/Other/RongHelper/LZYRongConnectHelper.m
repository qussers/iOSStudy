//
//  LZYRongConnectHelper.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/1.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYRongConnectHelper.h"
#import "LZYGlobalDefine.h"
#import "NSString+sha1.h"
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>
#import <BmobSDK/Bmob.h>
@implementation LZYRongConnectHelper

+ (BOOL)connectToRongCloud
{
    if (![BmobUser currentUser]) {
        return NO;
    }
    else{
        BmobUser *user = [BmobUser currentUser];
        NSString *token = [user objectForKey:@"token"];
        //createLink
        if (token && token.length > 0) {
            [self connectRongWithToken:token];
        }
        else{
            //重新请求token
            [self getTokenFromRunClouldWithUserId:user.objectId userName:user.username portraitUri:@"" success:^(NSString *token) {
                [user setObject:token forKey:@"token"];
                [user sub_updateInBackground];
                //重新链接
                [self connectRongWithToken:token];
            }];
        }
    }
    return YES;
}



+ (void)connectRongWithToken:(NSString *)token
{
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LZYNOTICE_LOGINSUCCESS object:nil];
        
    } error:^(RCConnectErrorCode status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LZYNOTICE_LOGINERROR object:nil];
    } tokenIncorrect:^{
        
        
        
    }];
}



/**
 *  获取融云的Token
 *
 *  @param userId      用户的用户id
 *  @param name        用户名
 *  @param portraitUri 用户头像所在的url
 */

+ (void)getTokenFromRunClouldWithUserId:(NSString *)userId userName:(NSString *)name portraitUri:(NSString *)portraitUri success:(void(^)(NSString *token))success
{
    NSString *AppKey = LZYRONGCLOUDKEY;
    NSDate *date = [NSDate date];
    NSString *Timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
    NSString *Nonce = [NSString stringWithFormat:@"%u",arc4random()];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",AppKey,Timestamp,Nonce];
    sign = [sign sha1];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = 10;
    request.HTTPMethod = @"POST";
    request.URL = [NSURL URLWithString:@"http://api.cn.rong.io/user/getToken.json"];
    [request setValue:AppKey forHTTPHeaderField:@"App-Key"];
    [request setValue:Nonce forHTTPHeaderField:@"Nonce"];
    [request setValue:Timestamp forHTTPHeaderField:@"Timestamp"];
    [request setValue:LZYRONGSECRET forHTTPHeaderField:@"appSecret"];
    
    //生成hashcode
    [request setValue:sign forHTTPHeaderField:@"Signature"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *body = [NSString stringWithFormat:@"userId=%@&name=%@&portraitUri=%@",userId,name,portraitUri];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    //构造Session
    NSURLSession *session = [NSURLSession sharedSession];
    //构造要执行的任务task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString *oldToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *arr = [oldToken componentsSeparatedByString:@"token"];
            NSString *secondstr = [arr lastObject];
            NSInteger length = secondstr.length;
            NSString *newToken = [secondstr substringWithRange:NSMakeRange(3, length-5)];
            success(newToken);
        }else{
            NSLog(@"%@",error);
        }
    }];
    [task resume];
}






@end
