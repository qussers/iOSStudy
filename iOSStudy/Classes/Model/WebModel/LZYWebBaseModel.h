//
//  LZYWebBaseModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYWebBaseModel : BmobObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *describe;

//多张图片
@property (nonatomic, copy) NSArray *images;

//来源
@property (nonatomic, copy) NSString *source;

@end
