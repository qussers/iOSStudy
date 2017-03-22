//
//  LZYExParseCellViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailCellViewModel.h"


@interface LZYExParseResultViewModel : NSObject

//正确答案
@property (nonatomic, strong) NSArray *correctResults;

//你的答案
@property (nonatomic, strong) NSArray *yourResults;


- (NSString *)correctResultsString;

- (NSString *)yourResultsString;

- (BOOL)isCorrect;

@end


@interface LZYExParseCellViewModel : LZYExDetailCellViewModel

+ (instancetype)parseViewModelWithBaseViewModel:(LZYExDetailCellViewModel *)viewModel;

- (LZYExParseResultViewModel *)resultViewModel;

- (NSMutableArray *)discussDataSource;

//讨论点击事件
- (RACCommand *)discussClickCommand;

//刷新评论列表
- (RACSignal *)refreshDataSignal;

//加载更多评论
- (RACSignal *)loadMoreDataSignal;

@end
