//
//  LZYBaseWebViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseWebViewController.h"
#import "LZYGlobalDefine.h"
#import "NSString+LZYAdd.h"
@interface LZYBaseWebViewController ()


@end

@implementation LZYBaseWebViewController

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view beginLoading];
    if (!self.webUrl) {
        return;
    }
    if (![self.webUrl containsString:@"http://"] && ![self.webUrl containsString:@"https://"]) {
        self.webUrl = [NSString stringWithFormat:@"http://%@",self.webUrl];
    }
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
}


#pragma mark -

- (void)webView:(IMYWebView *)webView didFailLoadWithError:(NSError *)error
{
  
}

- (void)webViewDidStartLoad:(IMYWebView *)webView
{
  
}

- (void)webViewDidFinishLoad:(IMYWebView *)webView
{
    [webView evaluateJavaScript:@"document.documentElement.innerHTML" completionHandler:^(id result, NSError *error) {
        if (result && [result isKindOfClass:[NSString class]]) {
            self.htmlImages = [result filterImage];
        }
        NSLog(@"%@",result);
    }];
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id result, NSError *error) {
       
        if (result && [result isKindOfClass:[NSString class]]) {
            self.htmlTitle = result;
        }
        NSLog(@"%@",result);
        
    }];
    
}

#pragma mark - lazy
- (IMYWebView *)webView
{
    if (!_webView) {
        _webView = [[IMYWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
        _webView.delegate = self;
       
    }
    
    return _webView;
}


@end
