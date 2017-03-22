//
//  LZYExDetailModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYExDetailModel : BmobObject

//题目
@property (nonatomic, copy) NSString *title;

//试题类型 0：单选题 1：多选题
@property (nonatomic, assign) NSInteger exType;

//选项
@property (nonatomic, strong) NSArray *options;

//答案
@property (nonatomic, strong) NSArray *answers;

//评论数
@property (nonatomic, assign) NSInteger commentCount;

@end
