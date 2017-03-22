//
//  LZYWebPageModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/26.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYWebPageModel : BmobObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, copy) NSString *describe;

@property (nonatomic, strong) NSArray *tags;


//用户相关
@property (nonatomic, copy) NSString *userName;

//用户id
@property (nonatomic, copy) NSString *userId;

//用户图标
@property (nonatomic, copy) NSString *userIcon;


@property (nonatomic, strong) BmobUser *user;


//cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
