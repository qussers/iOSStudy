//
//  LZYShareModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/1.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYShareModel : BmobObject

//主体内容
@property (nonatomic, copy) NSString *content;

//网址链接
@property (nonatomic, copy) NSString *url;

//链接描述
@property (nonatomic, copy) NSString *urlDescribe;

//网址图片
@property (nonatomic, copy) NSString *urlImageUrl;

//评论数
@property (nonatomic, assign) NSInteger commentCount;

//打赏数
@property (nonatomic, assign) NSInteger rewordCound;

//用户名称
@property (nonatomic, copy) NSString *userName;

//用户id
@property (nonatomic, copy) NSString *userId;

//用户头像缩略地址
@property (nonatomic, copy) NSString *userIcon;

//当前用户
@property (nonatomic, strong) BmobUser *user;

//cell高度缓存
@property (nonatomic, assign) CGFloat cellHeight;

@end
