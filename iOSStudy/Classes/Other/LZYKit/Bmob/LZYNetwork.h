//
//  LZYNetwork.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LZYBmobSMSModel.h"

@interface LZYNetwork : NSObject

//条件查询
+ (void)requestDataWithBMOBTableName:(NSString *)name
                          conditions:(NSArray *)conditions
                             success:(void (^)(id result))success
                             failure:(void (^)(id result))failure;

//根据表明获取对应比目数据
+ (void)requestDataWithBMOBTableName:(NSString *)name
                             success:(void(^)(id result))success
                             failure:(void(^)(id result))failure;

//获取不同科目的数据
+ (void)requestSubjectTitlesWithTableName:(NSString *)name
                                  success:(void(^)(NSArray *result))success
                                  failure:(void(^)(id result))failure;

//根据科目名称获取对应题目和资源
+ (void)requestSubjectContentWithSubjectTag:(NSString *)subjectTag
                                  tableName:(NSString *)tableName
                                    success:(void(^)(NSArray *result))success
                                    failure:(void(^)(id result))failure;

//获取招聘信息详情
+ (void)requestInviteJobWithTableName:(NSString *)name
                              success:(void(^)(NSArray *result))success
                              failure:(void(^)(id result))failure;


//获取面试信息详情
+ (void)requestInterviewWithTableName:(NSString *)name
                              success:(void(^)(NSArray *result))success
                              failure:(void(^)(id result))failure;

//用户登录 账户+密码
+ (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^)(id user))success
                 failure:(void(^)(id result))failure;


//用户登录 手机号+密码
+ (void)loginWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                           SMSCode:(NSString *)SMScode
                           success:(void(^)(id user))success
                           failure:(void(^)(id result))failure;

//用户注册+登录 手机号+验证码
+ (void)registerAndLoginWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                                      SMSCode:(NSString *)SMScode
                                      success:(void(^)(id user))success
                                      failure:(void(^)(id result))failure;

//用户注册  手机号+验证码
+ (void)registerWithMobilPhoneNumber:(NSString *)mobilePhoneNumber
                             SMSCode:(NSString *)SMScode
                            password:(NSString *)password
                             success:(void(^)(id user))success
                             failure:(void(^)(id result))failure;


//请求验证码
+ (void)requestSMSWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                               SMSModel:(LZYBmobSMSModel *)smsModel
                                success:(void(^)(NSInteger msgId))success
                                failure:(void(^)(id result))failure;

@end
