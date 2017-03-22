//
//  LZYUserTool.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/7.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYUserTool.h"
#import "LZYChatTool.h"
@implementation LZYUserTool

+ (void)userClickCommentBtnFromViewController:(UIViewController *)vc user:(BmobUser *)user
{
    [vc.navigationController pushViewController:[LZYChatTool chatToSomeBody:user] animated:YES];
    
}
@end
