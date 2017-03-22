//
//  LZYExDetailCollectionView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYExDetailViewModel.h"


@interface LZYExDetailCollectionView : UIResponder

@property (nonatomic, strong) RACSubject *allOptionCompletedSubject;

+ (instancetype)instanceWithViewModel:(LZYExDetailViewModel *)viewModel;

- (LZYExDetailViewModel *)viewModel;

- (UICollectionView *)collectionView;

- (RACCommand *)fetchDataCommand;


- (LZYExDetailModel *)currentModel;


@end
