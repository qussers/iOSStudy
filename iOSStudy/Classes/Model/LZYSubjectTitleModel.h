//
//  LZYSubjectTitleModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYSubjectTitleModel : BmobObject

//科目名称
@property (nonatomic, copy) NSString *subTitle;

//所属模块主题颜色
@property (nonatomic, copy) NSString *color;

@end
