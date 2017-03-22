//
//  LZYExDetailViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "LZYExDetailCellViewModel.h"


@interface LZYExDetailViewModel : NSObject

+ (instancetype)viewModelWithObjectId:(NSString *)objectId;

- (NSArray <LZYExDetailCellViewModel *> *)allData;

- (RACSignal *)refreshDataSignal;

- (RACSignal *)loadMoreDataSignal;


/***************业务逻辑处理**************/

- (NSInteger)numberOfSections;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (LZYExDetailCellViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
