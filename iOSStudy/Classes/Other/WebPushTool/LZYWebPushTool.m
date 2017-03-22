//
//  LZYWebPushTool.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/9.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYWebPushTool.h"
#import "LZYBrowserSearchWebViewController.h"
@implementation LZYWebPushTool

+ (void)userClickWebUrlBtnFormViewController:(UIViewController *)viewController url:(NSString *)url
{
    LZYBrowserSearchWebViewController *vc = [[LZYBrowserSearchWebViewController alloc] init];
    vc.webUrl = url;
    [viewController.navigationController pushViewController:vc animated:YES];
}
@end
