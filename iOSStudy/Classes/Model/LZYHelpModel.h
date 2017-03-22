//
//  LZYHelpModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/24.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYHelpModel : BmobObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *userIcon;

@property (nonatomic, strong) BmobUser *user;

//辅助计算高度
@property (nonatomic, assign) CGFloat cellHeight;

//底部工具栏距离上部约束
@property (nonatomic, assign) CGFloat tooBarYCons;

@end
