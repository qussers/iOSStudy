//
//  LZYCommentTool.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/7.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYCommentTool.h"
#import "LZYCommentViewController.h"
#import "LZYCommentBridgeModel.h"
#import "LZYEditHelpViewController.h"
@implementation LZYCommentTool

//点击跳转进编辑列表
+ (void)userClickCommentBtnFromViewController:(UIViewController *)vc commentBridge:(LZYCommentBridgeModel *)commentBridge
{
    LZYCommentViewController *commentVc = [[LZYCommentViewController alloc] init];
    commentVc.commentBridge = commentBridge;
    [vc.navigationController pushViewController:commentVc animated:YES];

}

+ (void)userClickEditCommentBtnFromViewController:(UIViewController *)vc commentBridge:(LZYCommentBridgeModel *)commentBridge
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYEditHelpViewController *editVc = [storyboard instantiateViewControllerWithIdentifier:@"editHelpViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editVc];
    editVc.commentBridge = commentBridge;
    [vc presentViewController:nav animated:YES completion:nil];
}

@end
