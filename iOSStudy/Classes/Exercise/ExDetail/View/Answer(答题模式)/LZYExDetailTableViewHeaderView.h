//
//  LZYExDetailTableViewHeaderView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYExDetailCellViewModel.h"
@interface LZYExDetailTableViewHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *exTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *exTitleLabel;

@property (nonatomic, strong) LZYExDetailCellViewModel *viewModel;

@end
