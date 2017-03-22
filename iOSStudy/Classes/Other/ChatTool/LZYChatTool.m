//
//  LZYChatTool.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/7.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYChatTool.h"
#import <BmobSDK/Bmob.h>
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
@implementation LZYChatTool

+ (UIViewController *)chatToSomeBody:(BmobUser *)user
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = 0;
    conversationVC.targetId = user.objectId;
    conversationVC.title = @"对话";
    return conversationVC;
}

@end
