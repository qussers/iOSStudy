//
//  LZYExSubmitCellViewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZYExSubmitModel.h"
#import <ReactiveObjC.h>
@interface LZYExSubmitCellViewModel : NSObject

+ (instancetype)viewModelWithModel:(LZYExSubmitModel *)model;

- (LZYExSubmitModel *)model;


- (NSString *)modelCount;


- (BOOL)modelCompleted;


- (BOOL)modelCorrect;
@end
