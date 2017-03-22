//
//  LZYExParseDiscussTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYExParseCellViewModel.h"
@interface LZYExParseDiscussTableViewCell : UITableViewCell

@property (nonatomic, strong) LZYExParseCellViewModel *viewModel;


@property (weak, nonatomic) IBOutlet UIButton *disBtn;


@end
