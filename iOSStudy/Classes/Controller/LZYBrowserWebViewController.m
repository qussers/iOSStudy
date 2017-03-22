//
//  LZYBrowserWebViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBrowserWebViewController.h"
#import "LZYBrowserToolBarView.h"
#import "LZYGlobalDefine.h"
#import "UIView+Xib.h"
#import "MBProgressHUD+LZYAdd.h"

#import "LZYBrowserSaveTableViewController.h"
#import "LZYBrowserShareTableViewController.h"

#import "LZYWebPageModel.h"

@interface LZYBrowserWebViewController ()<LZYBrowserToolBarViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) LZYBrowserToolBarView *toolBar;

@end

@implementation LZYBrowserWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.toolBar];
     self.webView.scrollView.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float newOffsetY = 0;
    static float oldOffsetY = 0;
    newOffsetY = scrollView.contentOffset.y;
    if (ABS(newOffsetY - oldOffsetY) > 15) {
        if (newOffsetY > oldOffsetY) {
            //上滑
            [self.toolBar setHidden:YES];
            [self.navigationController.navigationBar setHidden:YES];
            
        }else if(newOffsetY < oldOffsetY){
            //下滑
            [self.toolBar setHidden:NO];
            [self.navigationController.navigationBar setHidden:NO];
        }
    }
    
    oldOffsetY = newOffsetY;
}


#pragma mark - LZYBrowserToolBarViewDelegate

- (void)browserToolBarClickWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [self.webView goBack];
        }
            break;
        case 1:
        {
            [self.webView goForward];
        }
            break;
        case 2:
        {
            [self shareInfo];
        }
            break;
        case 3:
        {
            [self saveInfo];
        }
            break;
        case 4:
        {
            [self copyCurrentUrl];
        }
            break;
            
        default:
            break;
    }
}


//拷贝当前链接
- (void)copyCurrentUrl
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.webView.URL.absoluteString;
    if (self.webView.URL.absoluteString) {
        pasteboard.string = self.webView.URL.absoluteString;
    }else{
        pasteboard.string = self.webUrl;
    }
    [MBProgressHUD showSuccess:@"已复制"];
}


//弹出保存
- (void)saveInfo
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYBrowserSaveTableViewController *saveVc = [storyboard instantiateViewControllerWithIdentifier:@"browserSaveTableViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:saveVc];
    
    LZYWebPageModel *webPageModel = [[LZYWebPageModel alloc] init];
    webPageModel.url = self.webView.URL.absoluteString;
    webPageModel.images = self.htmlImages;
    webPageModel.title = self.htmlTitle;
    saveVc.webPageModel = webPageModel;
    [self presentViewController:nav animated:YES completion:nil];

}

//弹出分享
- (void)shareInfo
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYBrowserShareTableViewController *shareVc = [storyboard instantiateViewControllerWithIdentifier:@"browserShareTableViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shareVc];
    LZYWebPageModel *webPageModel = [[LZYWebPageModel alloc] init];
    webPageModel.url = self.webView.URL.absoluteString;
    webPageModel.images = self.htmlImages;
    webPageModel.title = self.htmlTitle;
    shareVc.webPageModel = webPageModel;
    [self presentViewController:nav animated:YES completion:nil];
}



#pragma mark - lazy
- (LZYBrowserToolBarView *)toolBar
{
    if (!_toolBar) {
        _toolBar = (LZYBrowserToolBarView *)[UIView loadViewWithXibName:@"LZYBrowserToolBarView"];
        _toolBar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
        _toolBar.delegate = self;
    }
    return _toolBar;
}

@end
