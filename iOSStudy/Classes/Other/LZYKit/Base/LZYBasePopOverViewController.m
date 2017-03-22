//
//  LZYBasePopOverViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBasePopOverViewController.h"

@interface LZYBasePopOverViewController ()

@end

@implementation LZYBasePopOverViewController


- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//重写preferredContentSize，让popover返回你期望的大小
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.view!= nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        CGSize size = [self.view sizeThatFits:tempSize];  //sizeThatFits返回的是最合适的尺寸，但不会改变控件的大小
        return size;
    }else {
        return [super preferredContentSize];
    }
}

- (void)setPreferredContentSize:(CGSize)preferredContentSize{
    super.preferredContentSize = preferredContentSize;
}
@end
