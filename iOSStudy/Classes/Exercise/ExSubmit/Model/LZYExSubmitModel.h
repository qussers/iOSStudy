//
//  LZYExSubmitModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZYExSubmitModel : NSObject

//题目所在序号
@property (nonatomic, assign) NSInteger index;

//是否已经选中
@property (nonatomic, assign) BOOL isSelected;

//是否正确（用于提交之后）
@property (nonatomic, assign) BOOL isCorrect;

@end
