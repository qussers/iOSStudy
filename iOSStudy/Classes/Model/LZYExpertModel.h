//
//  LZYExpertModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/3.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

//专家列表
@interface LZYExpertModel : BmobObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *describe;


@end
