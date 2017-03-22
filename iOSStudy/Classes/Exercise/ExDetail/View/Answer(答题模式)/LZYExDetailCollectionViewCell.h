//
//  LZYExDetailCollectionViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYExDetailCellViewModel.h"
@interface LZYExDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) RACSubject *cellClickSubject;

@property (nonatomic, strong) LZYExDetailCellViewModel *viewModel;

@end
