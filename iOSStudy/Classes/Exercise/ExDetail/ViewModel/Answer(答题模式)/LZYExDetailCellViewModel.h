//
//  LZYExDetailCellViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZYExDetailModel.h"
#import "LZYExDetailAnswerModel.h"
#import <ReactiveObjC.h>

extern NSString *LZYExDetailCellDidSelectedEvent;

@interface LZYExDetailTableViewCellViewModel : NSObject

+ (instancetype)viewModelWithModel:(LZYExDetailAnswerModel *)model;

- (LZYExDetailAnswerModel *)model;

- (NSString *)modelExAnswer;

- (NSString *)modelExAnserTitle;

- (BOOL)isSelected;

- (RACCommand *)selected;

- (RACCommand *)chancelSelected;

@end

@interface LZYExDetailCellViewModel : NSObject

+ (instancetype)viewModelWithModel:(LZYExDetailModel *)model;

- (LZYExDetailModel *)model;

//题目
- (NSString *)modelExTitle;

//选项
- (NSArray <LZYExDetailTableViewCellViewModel *>*)modelExOptions;

//答案
- (NSArray *)modelExAnswers;

//题目类型
- (NSString *)modelExType;




/*********************业务逻辑**********************/

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (LZYExDetailTableViewCellViewModel *)cellContentAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)cellRowHeightAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (RACCommand *)cellDidClick;


@end
