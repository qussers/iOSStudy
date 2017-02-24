//
//  LZYNetwork.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYNetwork.h"
#import "LZYGlobalDefine.h"
#import <BmobSDK/BmobQuery.h>
#import <BmobSDK/BmobObject+Subclass.h>

//所有科目标题表
#import "LZYSubjectTitleModel.h"

//具体科目表内容
#import "LZYSecondSubjectModel.h"

//招聘模型表
#import "LZYInviteJobModel.h"

//面试信息表
#import "LZYInterviewModel.h"

//查询条件模型
#import "LZYBmobQueryTypeModel.h"

//用户模型
#import "LZYUserModel.h"

@implementation LZYNetwork



+ (void)requestDataWithBMOBTableName:(NSString *)name
                          conditions:(NSArray *)conditions
                             success:(void (^)(id result))success
                             failure:(void (^)(id result))failure
{
    //网络检查
    BmobQuery   *bquery = [BmobQuery queryWithClassName:name];
    
    if (conditions && conditions.count > 0) {
        
        for (LZYBmobQueryTypeModel *model in conditions) {
            
            switch (model.type) {
                case kEqual:
                    [bquery whereKey:model.queryKeyName equalTo:model.queryValue];
                    break;
                case kNotEqual:
                    [bquery whereKey:model.queryKeyName notEqualTo:model.queryValue];
                    break;
                case kLessThan:
                    [bquery whereKey:model.queryKeyName lessThan:model.queryValue];
                    break;
                case kLessThanOrEqual:
                    [bquery whereKey:model.queryKeyName lessThanOrEqualTo:model.queryValue];
                    break;
                case kGreater:
                    [bquery whereKey:model.queryKeyName greaterThan:model.queryValue];
                    break;
                case kGreaterThanOrEqual:
                    [bquery whereKey:model.queryKeyName greaterThanOrEqualTo:model.queryValue];
                    break;
                default:
                    break;
            }
        }
    }
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            failure(error);
        }else{
            success(array);
        }
    }];
    
}

//根据表明查询全部数据
+ (void)requestDataWithBMOBTableName:(NSString *)name
                             success:(void (^)(id))success
                             failure:(void (^)(id))failure
{
    [self requestDataWithBMOBTableName:name
                            conditions:nil success:^(id result) {
                                success(result);
                            } failure:^(id result) {
                                failure(result);
                            }];
    
    
}

+ (void)requestSubjectTitlesWithTableName:(NSString *)name
                                  success:(void (^)(NSArray *))success
                                  failure:(void (^)(id))failure
{
    if (!name) {
        name = LZYBMOBSUBJECTTITLENAME;
    }
    [self requestDataWithBMOBTableName:name success:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            NSMutableArray *muResult = @[].mutableCopy;
            for (BmobObject *obj in result) {
                LZYSubjectTitleModel *model = [[LZYSubjectTitleModel alloc] initFromBmobObject:obj];
                [muResult addObject:model];
            }
            success(muResult);
        }
        else{
            failure(LZYBMOBERRORNOTARRAY);
        }
        
    } failure:^(id result) {
        failure(result);
    }];

}

//根据科目，检索科目（知识点、问题）的内容列表
+ (void)requestSubjectContentWithSubjectTag:(NSString *)subjectTag
                                  tableName:(NSString *)tableName
                                    success:(void (^)(NSArray *))success
                                    failure:(void (^)(id))failure
{

    if (!subjectTag) {
        return;
    }
    NSMutableArray *mConditions = @[].mutableCopy;
    if (subjectTag) {
       LZYBmobQueryTypeModel *queryModel = [[LZYBmobQueryTypeModel alloc] initWithQueryKeyName:@"subject_tag" queryType:kEqual disValue:subjectTag];
        [mConditions addObject:queryModel];
    }
    [self requestDataWithBMOBTableName:tableName conditions:mConditions success:^(id result) {
       
        if ([result isKindOfClass:[NSArray class]]) {
            NSMutableArray *muResult = @[].mutableCopy;
            for (BmobObject *obj in result) {
                LZYSecondSubjectModel *model = [[LZYSecondSubjectModel alloc] initFromBmobObject:obj];
                [muResult addObject:model];
            }
            success(muResult);
        }
        else{
            failure(LZYBMOBERRORNOTARRAY);
        }
    } failure:^(id result) {
        failure(result);
    }];
    
}

//获取招聘信息详情
+ (void)requestInviteJobWithTableName:(NSString *)name
                              success:(void(^)(NSArray *result))success
                              failure:(void(^)(id result))failure
{
    if (!name) {
        name = LZYBMOBINVITEJOB;
    }
    [self requestDataWithBMOBTableName:name success:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = @[].mutableCopy;
            for (BmobObject *obj in result) {
                LZYInviteJobModel *model = [[LZYInviteJobModel alloc] initFromBmobObject:obj];

                [mArr addObject:model];
            }
            success(mArr);
        }
        
    } failure:^(id result) {
        failure(result);
    }];
}

//获取面试信息详情
+ (void)requestInterviewWithTableName:(NSString *)name
                              success:(void(^)(NSArray *result))success
                              failure:(void(^)(id result))failure
{
    if (!name) {
        name = LZYBMOBINTERVIEW;
    }
    [self requestDataWithBMOBTableName:name success:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = @[].mutableCopy;
            for (BmobObject *obj in result) {
                LZYInterviewModel *model = [[LZYInterviewModel alloc] initFromBmobObject:obj];
                [mArr addObject:model];
            }
            success(mArr);
        }
        
    } failure:^(id result) {
        failure(result);
    }];
    
}


//用户登录 账户+密码
+ (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^)(id user))success
                 failure:(void(^)(id result))failure
{

    [BmobUser loginWithUsernameInBackground:account password:password block:^(BmobUser *user, NSError *error) {
        if (user) {
            LZYUserModel *model = [[LZYUserModel alloc] initFromBmobObject:user];
            success(model);
        }
        else{
            failure(error);
        }
    }];
}



//用户登录 手机号+密码
+ (void)loginWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                           SMSCode:(NSString *)SMScode
                           success:(void(^)(id user))success
                           failure:(void(^)(id result))failure
{
    [BmobUser loginInbackgroundWithMobilePhoneNumber:mobilePhoneNumber andSMSCode:SMScode block:^(BmobUser *user, NSError *error) {
        if (user) {
            LZYUserModel *model = [[LZYUserModel alloc] initFromBmobObject:user];
            success(model);
        }
        else{
            failure(error);
        }
        
    }];
}

//用户注册+登录 手机号+验证码
+ (void)registerAndLoginWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                                      SMSCode:(NSString *)SMScode
                                      success:(void(^)(id user))success
                                      failure:(void(^)(id result))failure
{

    [BmobUser signOrLoginInbackgroundWithMobilePhoneNumber:mobilePhoneNumber andSMSCode:SMScode block:^(BmobUser *user, NSError *error) {
       
        if (user) {
            LZYUserModel *model = [[LZYUserModel alloc] initFromBmobObject:user];
            success(model);
        }
        else{
            failure(error);
        }
        
    }];
}

//请求验证码
+ (void)requestSMSWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                               SMSModel:(LZYBmobSMSModel *)smsModel
                                success:(void(^)(NSInteger msgId))success
                                failure:(void(^)(id result))failure
{
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:mobilePhoneNumber andTemplate:smsModel.smsTypeName resultBlock:^(int number, NSError *error) {
       
        if (error) {
            failure(error);
        }
        else{
            success(number);
        }
    }];
}



+ (void)registerWithMobilPhoneNumber:(NSString *)mobilePhoneNumber
                             SMSCode:(NSString *)SMScode
                            password:(NSString *)password
                             success:(void(^)(id user))success
                             failure:(void(^)(id result))failure
{
    [BmobUser signOrLoginInbackgroundWithMobilePhoneNumber:mobilePhoneNumber SMSCode:SMScode andPassword:password block:^(BmobUser *user, NSError *error) {
       
        if (user) {
            LZYUserModel *userModel = [[LZYUserModel alloc] initFromBmobObject:user];
            success(userModel);
        }
        else{
            failure(error);
        }
    }];

}

@end
