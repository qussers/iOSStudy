//
//  LZYNetLoadView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, networkLoadType) {
    kLoading,
    kNetworkError,
    kLoadNone,
};

@interface LZYNetLoadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, assign) networkLoadType loadType;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY;

@property (nonatomic, assign) UITableViewCellSeparatorStyle tableViewCellSeparatorStyle;

//更改位置约束
- (void)changeY:(CGFloat)distance;
@end
