//
//  LZYSubjectContentViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSubjectContentViewController.h"
#import "IMYWebView.h"
#import "LZYGlobalDefine.h"
@interface LZYSubjectContentViewController ()<IMYWebViewDelegate>

@property (nonatomic, strong) IMYWebView *webView;

@end

@implementation LZYSubjectContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadWebViewContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebViewContent
{
    [self.view beginLoading];
    if (!self.webUrl) {
        return;
    }
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
}


#pragma mark - 

- (void)webView:(IMYWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.view loadError];
}

- (void)webViewDidStartLoad:(IMYWebView *)webView
{
    [self.view endLoading];
}

#pragma mark - lazy
- (IMYWebView *)webView
{
    if (!_webView) {
        _webView = [[IMYWebView alloc] initWithFrame:CGRectMake(0, 64, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64)];
        _webView.delegate = self;
    }
    
    return _webView;
}

@end
