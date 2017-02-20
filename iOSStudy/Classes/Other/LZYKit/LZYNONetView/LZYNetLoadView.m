//
//  LZYNetLoadView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYNetLoadView.h"

@implementation LZYNetLoadView


- (void)setLoadType:(networkLoadType)loadType
{
    _loadType = loadType;
    
    switch (loadType) {
        case kLoading:
            self.contentLabel.text = @"数据加载中...";
            break;
        case kNetworkError:
            self.contentLabel.text = @"网络错误,请重试";
            break;
        case kLoadNone:
            self.contentLabel.text = @"暂无数据哦~";
            break;
        default:
            break;
    }
}


@end
