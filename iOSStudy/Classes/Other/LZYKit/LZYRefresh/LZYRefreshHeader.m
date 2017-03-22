//
//  LZYRefreshHeader.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/2.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYRefreshHeader.h"

@implementation LZYRefreshHeader

- (void)prepare
{
    [super prepare];
    
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
//        CGRect react = self.frame;
//        react.size.height = 50;
//        self.frame = react;
//    
//        NSMutableArray *idleImages = [NSMutableArray array];
//        for (NSUInteger i = 0; i <= 15; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"lzy_dropdown_anim_%ld", i]];
//            [idleImages addObject:image];
//        }
//        [self setImages:idleImages forState:MJRefreshStateIdle];
////    
//        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//        NSMutableArray *pullingingImages = [NSMutableArray array];
//        for (NSUInteger i = 15; i <= 70; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"lzy_dropdown_anim_%ld", i]];
//            [pullingingImages addObject:image];
//        }
//        [self setImages:pullingingImages forState:MJRefreshStatePulling];
//
//    
//        NSMutableArray *refreshingImages = [NSMutableArray array];
//        for (NSUInteger i = 64; i<=120; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"lzy_dropdown_anim_%ld", i]];
//            [refreshingImages addObject:image];
//        }
//    
        // 设置正在刷新状态的动画图片
       // [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
//    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
