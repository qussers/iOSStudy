//
//  LZYExSubmitResultCollectionViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYExSubmitCellViewModel.h"
@interface LZYExSubmitResultCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) LZYExSubmitCellViewModel *viewModel;

@end
