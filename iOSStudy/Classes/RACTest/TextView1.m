//
//  TextView1.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "TextView1.h"

@implementation TextView1

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self initUI];
    }
    
    return self;
}

- (void)initUI
{
    UIButton *(^makeButton)(NSString *,CGRect) = ^(NSString *title,CGRect frame){
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        return button;
    };
    _btn = makeButton(@"惦记我",self.bounds);
    [self addSubview:_btn];

}

- (void)btnClick
{
    NSLog(@"按钮点击事件");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1.0f];
        NSLog(@"我是延时后的事件哦!~~~");
    });
}
@end
