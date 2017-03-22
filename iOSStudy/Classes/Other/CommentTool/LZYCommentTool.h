//
//  LZYCommentTool.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/7.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYCommentBridgeModel.h"
@interface LZYCommentTool : NSObject

//点击评论的处理事件
+ (void)userClickCommentBtnFromViewController:(UIViewController *)vc commentBridge:(LZYCommentBridgeModel *)commentBridge;

+ (void)userClickEditCommentBtnFromViewController:(UIViewController *)vc commentBridge:(LZYCommentBridgeModel *)commentBridge;

@end
