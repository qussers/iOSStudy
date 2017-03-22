//
//  LZYExDetailTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import "LZYExDetailCellViewModel.h"
@interface LZYExDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) LZYExDetailTableViewCellViewModel *viewModel;

@end
