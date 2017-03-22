//
//  LZYExSubmitViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZYExSubmitCellViewModel.h"
#import <ReactiveObjC.h>
@interface LZYExSubmitViewModel : NSObject


+ (instancetype)viewModelWithDataSource:(NSArray *)data;


- (NSArray <LZYExSubmitCellViewModel *> *)allData;

//转化数据
- (RACSignal *)loadDataSignal;


- (NSInteger)numberOfItemsInSection:(NSInteger)section;


@end
