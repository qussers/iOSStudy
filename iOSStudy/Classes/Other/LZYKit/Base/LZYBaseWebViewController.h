//
//  LZYBaseWebViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseViewController.h"
#import "IMYWebView.h"
@interface LZYBaseWebViewController : LZYBaseViewController <IMYWebViewDelegate>

@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, strong) IMYWebView *webView;
@property (nonatomic, strong) NSArray *htmlImages;
@property (nonatomic, copy) NSString *htmlTitle;
@end
