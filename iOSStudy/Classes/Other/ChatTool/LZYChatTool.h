//
//  LZYChatTool.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/7.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BmobUser;
@interface LZYChatTool : NSObject

+ (UIViewController *)chatToSomeBody:(BmobUser *)user;

@end
