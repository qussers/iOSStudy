//
//  LZYCommentModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/28.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYCommentModel : BmobObject

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *userIcon;

@property (nonatomic, strong) BmobUser *user;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, assign) NSInteger rewordCount;


//评论类型 --1:求助 2:分享 3:面试 4:招聘
@property (nonatomic, assign) NSInteger commentType;

@property (nonatomic, copy) NSString *pointerObjectName;
//链接上层信息id
@property (nonatomic, copy) NSString *pointerId;

@end
