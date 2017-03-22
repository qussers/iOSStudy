//
//  LZYExSubTitleViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

#import "LZYExSubTitleModel.h"

@interface LZYExCellSubTitleViewModel : NSObject

+ (instancetype)viewModelWithSubTitleModel:(LZYExSubTitleModel *)model;

- (LZYExSubTitleModel *)model;

- (NSString *)modelTitleText;

- (NSString *)modelContentCountText;



@end
