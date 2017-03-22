//
//  LZYExTitleViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZYExCellTitleViewModel.h"

/********************中央控制器事件*********************/
extern NSString *LZYExTitleCellDidSelectedEvent;

@interface LZYExTitleViewModel : NSObject

+ (instancetype)viewModel;

- (NSArray<LZYExCellTitleViewModel *> *)allDatas;

- (RACSignal *)refreshDataSignal;

- (RACSignal *)loadMoreDataSignal;


//返回有几个分组
- (NSInteger)numberOfSections;

//返回分个分组有多少元素
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

//返回头部ViewModel
- (LZYExCellTitleViewModel *)sectionViewModelInSection:(NSInteger)section;

//返回对应的viewmodel
- (LZYExCellSubTitleViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

//返回cell高度
- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

//cell点击事件
- (void)cellDidSelectedAtIndexPath:(NSIndexPath *)indexPath;


@end
