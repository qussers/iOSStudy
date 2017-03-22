//
//  LZYBrowserSearchWebViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/26.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBrowserSearchWebViewController.h"
#import "LZYBrowserHeaderView.h"
#import "UIView+Xib.h"
#import "LZYGlobalDefine.h"
@interface LZYBrowserSearchWebViewController ()<LZYBrowserHeaderViewDelegate>

@property (nonatomic, strong) LZYBrowserHeaderView *searchHeaderView;

@end

@implementation LZYBrowserSearchWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitleView:self.searchHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchButtonClickWithSearchUrl:(NSString *)url
{
    
    LZYBrowserWebViewController *v = [[LZYBrowserWebViewController alloc] init];
    v.webUrl = url;
    [self.navigationController pushViewController:v animated:YES];    
}


#pragma mark - lazy
- (LZYBrowserHeaderView *)searchHeaderView
{
    if (!_searchHeaderView) {
        _searchHeaderView = (LZYBrowserHeaderView *)[UIView loadViewWithXibName:@"LZYBrowserHeaderView"];
        _searchHeaderView.delegate = self;
        _searchHeaderView.frame = CGRectMake(0, 20, LZYSCREEN_WIDTH , 44);
        _searchHeaderView.backgroundColor = [UIColor clearColor];
    }
    
    return _searchHeaderView;
}


@end
