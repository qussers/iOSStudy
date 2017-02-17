//
//  LZYSecondSubjectModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYSecondSubjectModel : BmobObject

//题目
@property (nonatomic, copy) NSString *subjectTitle;

//难度
@property (nonatomic, assign) NSInteger difficult;

//答案链接
@property (nonatomic, copy) NSString *answerUrl;

//所属一级分类
@property (nonatomic, copy) NSString *subjectTag;

//所属二级分类
@property (nonatomic, copy) NSString *tag;

@end
