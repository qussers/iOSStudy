//
//  LZYNetwork.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LZYBmobSMSModel.h"
#import "LZYBmobQueryTypeModel.h"

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




//根据模型名称 获取对应数据表
+ (void)requestObjectModelWithTableName:(Class)classObj
                                success:(void(^)(NSArray *result))success
                                failure:(void(^)(id result))failure;

//根据模型名称 获取对应数据表 加条件
+ (void)requestObjectModelWithTableName:(Class)classObj
                             conditions:(NSArray *)conditions
                                success:(void(^)(NSArray *result))success
                                failure:(void(^)(id result))failure;









#pragma mark - 登录信息

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

//验证验证码是否合法
+ (void)verfitySMSWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                                SMSCode:(NSString *)smsCode
                                result:(void(^)(BOOL isSuccess, id error))result;

//重置密码
+ (void)resetPasswordWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                                   SMSCode:(NSString *)smsCode
                               newPassword:(NSString *)password
                                    result:(void(^)(BOOL isSuccess, id error))result;


#pragma mark - 上传文件
+ (void)uploadImages:(NSArray *)images
       progressBlock:(void(^)(int index, float progress))progressBlock
              result:(void(^)(NSArray *array, BOOL isSuccessfule, NSError *error))block;


#pragma mark - 云端逻辑
+ (void)requestCloudAPI:(NSString *)apiName paramerters:(NSDictionary *)parameters block:(void(^)(id result, NSError *error))result;


@end
