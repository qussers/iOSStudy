//
//  LZYInviteJobModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYInviteJobModel :BmobObject

//
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *userIcon;


//
@property (nonatomic, strong) BmobUser *user;

//公司所属城市
@property (nonatomic, copy) NSString *cityName;

//公司城区
@property (nonatomic, copy) NSString *townName;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *email;

//公司名称
@property (nonatomic, copy) NSString *companyName;

//公司类型
@property (nonatomic, copy) NSString *companyType;

//职位工作经验要求
@property (nonatomic, copy) NSString *experience;

//招聘发布人职位
@property (nonatomic, copy) NSString *invitePosition;

//职位标题
@property (nonatomic, copy) NSString *jobTitle;

//薪资区间
@property (nonatomic, copy) NSString *salary;

//学历
@property (nonatomic, copy) NSString *academic;

//岗位职责
@property (nonatomic, copy) NSString *duty;

//任职要求
@property (nonatomic, copy) NSString *demand;

//福利待遇标签
@property (nonatomic, strong) NSArray *tags;


@end
