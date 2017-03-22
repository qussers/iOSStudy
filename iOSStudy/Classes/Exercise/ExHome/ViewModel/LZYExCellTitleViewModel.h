//
//  LZYExCellTitleViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZYExCellSubTitleViewModel.h"
#import "LZYExTitleModel.h"

extern NSString *SpreadEvent;
extern NSString *kCellViewModel;


@interface LZYExCellTitleViewModel : NSObject

/*********模型构建*******/
+ (instancetype)viewModelWithModel:(LZYExTitleModel *)model;

- (void)addSubViewModel:(LZYExCellSubTitleViewModel *)subViewModel;

- (NSArray <LZYExCellSubTitleViewModel *> *)subViewModels;

- (LZYExTitleModel *)model;


/*********视图数据*******/
- (NSString *)modelTitleText;



/*********业务处理*******/

//展开事件
- (RACCommand *)spreadCommand;


//是否展开状态
- (BOOL)isSpreadOut;




@end
