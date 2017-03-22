//
//  LZYExTitleHeaderView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYExCellTitleViewModel.h"
@interface LZYExTitleHeaderView : UIView

@property (nonatomic, strong) LZYExCellTitleViewModel *viewModel;

- (IBAction)btnClick:(UIButton *)sender;

//头部点击回调
@property (nonatomic, strong) RACSubject *headClickSubject;

@end
