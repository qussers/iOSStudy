//
//  UIView+newLoadView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "UIView+NetLoadView.h"
#import <objc/runtime.h>
#import "UIView+Xib.h"
static NSString *loadViewKey = @"loadViewKey";

@implementation UIView (newLoadView)

- (void)beginLoading
{
    for (UIView *aView in self.subviews) {
        if ([aView isKindOfClass:[LZYNetLoadView class]]) {
            return;
        }
    }
    if (!self.loadView) {
        self.loadView = (LZYNetLoadView *)[UIView loadViewWithXibName:@"LZYNetLoadView"];
        self.loadView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        if([self isKindOfClass:[UITableView class]] ){
            UITableView *tableView = (UITableView *)self;
            self.loadView.tableViewCellSeparatorStyle = tableView.separatorStyle;
            [tableView setScrollEnabled:NO];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
        }
    }
    self.loadView.loadType = kLoading;
    [self addSubview:self.loadView];
    
}

- (void)endLoading
{
    if (self.loadView) {
        if([self isKindOfClass:[UITableView class]] ){
            UITableView *tableView = (UITableView *)self;
            [tableView setScrollEnabled:YES];
            [tableView setSeparatorStyle:self.loadView.tableViewCellSeparatorStyle];
        }
        [self.loadView removeFromSuperview];
        self.loadView = nil;
    }
}

- (void)loadError
{
    if (self.loadView) {
        self.loadView.loadType = kNetworkError;
    }
    else{
        [self beginLoading];
        [self loadError];
    }
}

- (void)loadNone
{
    if (self.loadView) {
        self.loadView.loadType = kLoadNone;
    }
}



#pragma mark - setter&& getter

- (void)setLoadView:(LZYNetLoadView *)loadView
{
    [self willChangeValueForKey:@"loadViewKey"];
    objc_setAssociatedObject(self, &loadViewKey, loadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"loadViewKey"];
}

- (LZYNetLoadView *)loadView
{
    return objc_getAssociatedObject(self, &loadViewKey);
}


@end
