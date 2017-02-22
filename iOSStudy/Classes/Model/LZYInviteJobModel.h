//
//  LZYInviteJobModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/BmobObject.h>

@interface LZYInviteJobModel : BmobObject


//公司所属城市
@property (nonatomic, copy) NSString *cityName;

//公司城区
@property (nonatomic, copy) NSString *townName;

//公司名称
@property (nonatomic, copy) NSString *companyName;

//公司类型
@property (nonatomic, copy) NSString *companyType;

//职位工作经验要求
@property (nonatomic, copy) NSString *experience;

//招聘发布人姓名
@property (nonatomic, copy) NSString *inviteName;

//招聘发布人职位
@property (nonatomic, copy) NSString *invitePosition;

//招聘发布人id
@property (nonatomic, copy) NSString *inviteUserId;

//职位标题
@property (nonatomic, copy) NSString *jobTitle;

//薪资区间
@property (nonatomic, copy) NSString *salary;

//学历
@property (nonatomic, copy) NSString *academic;

@end
