//
//  LZYRongConnectHelper.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/1.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZYRongConnectHelper : NSObject

//链接到融云服务器
+ (BOOL)connectToRongCloud;

//获取token

/**
 *  获取融云的Token
 *
 *  @param userId      用户的用户id
 *  @param name        用户名
 *  @param portraitUri 用户头像所在的url
 *
 *
 */

+ (void)getTokenFromRunClouldWithUserId:(NSString *)userId userName:(NSString *)name portraitUri:(NSString *)portraitUri success:(void(^)(NSString *token))success;

@end
