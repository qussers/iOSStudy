//
//  LZYNetwork.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYNetwork.h"
#import "LZYGlobalDefine.h"
#import "NSString+LZYAdd.h"
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

//求助信息表
#import "LZYHelpModel.h"

//查询条件模型
#import "LZYBmobQueryTypeModel.h"



@implementation LZYNetwork



+ (void)requestDataWithBMOBTableName:(NSString *)name
                          conditions:(NSArray *)conditions
                             success:(void (^)(id result))success
                             failure:(void (^)(id result))failure
{
    //网络检查
    BmobQuery   *bquery = [BmobQuery queryWithClassName:name];
    
    //默认时间降序
    [bquery orderByDescending:@"updatedAt"];
    
    //默认会针对User做处理
    [bquery includeKey:@"user"];
    
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
                case kIncludeKey:
                    [bquery includeKey:model.queryKeyName];
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


//根据模型名称 获取对应数据表
+ (void)requestObjectModelWithTableName:(Class)classObj
                                success:(void(^)(NSArray *result))success
                                failure:(void(^)(id result))failure
{
    NSString *tableName = NSStringFromClass(classObj);
    
    [self requestDataWithBMOBTableName:tableName success:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = @[].mutableCopy;
            for (BmobObject *obj in result) {
                id model = [[classObj alloc] initFromBmobObject:obj];
                [mArr addObject:model];
            }
            success(mArr);
        }
        
    } failure:^(id result) {
        failure(result);
    }];
}

//根据模型名称 获取对应数据表
+ (void)requestObjectModelWithTableName:(Class)classObj
                             conditions:(NSArray *)conditions
                                success:(void(^)(NSArray *result))success
                                failure:(void(^)(id result))failure
{
    NSString *tableName = NSStringFromClass(classObj);
    
    [self requestDataWithBMOBTableName:tableName conditions:conditions success:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = @[].mutableCopy;
            for (BmobObject *obj in result) {
                id model = [[classObj alloc] initFromBmobObject:obj];
                [mArr addObject:model];
            }
            success(mArr);
        }
        
    } failure:^(id result) {
             failure(result);
    }];
}


#pragma mark -登录相关
//用户登录 账户+密码
+ (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^)(id user))success
                 failure:(void(^)(id result))failure
{

    [BmobUser loginWithUsernameInBackground:account password:password block:^(BmobUser *user, NSError *error) {
        if (user) {
            success(user);
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
            success(user);
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
            success(user);
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
            success(user);
        }
        else{
            failure(error);
        }
    }];

}

//验证验证码是否合法
+ (void)verfitySMSWithMobilePhoneNumber:(NSString *)mobilePhoneNumber
                                SMSCode:(NSString *)smsCode
                                result:(void(^)(BOOL isSuccess, id error))result;
{
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:mobilePhoneNumber andSMSCode:smsCode resultBlock:^(BOOL isSuccessful, NSError *error) {
        result(isSuccessful, error);
    }];

}

//重置新密码
+ (void)resetPasswordWithMobilePhoneNumber:(NSString *)mobilePhoneNumber SMSCode:(NSString *)smsCode newPassword:(NSString *)password    result:(void(^)(BOOL isSuccess, id error))result;
{
    [BmobUser resetPasswordInbackgroundWithSMSCode:smsCode andNewPassword:password block:^(BOOL isSuccessful, NSError *error) {
       
        result(isSuccessful, error);
        
    }];
}


+ (void)uploadImages:(NSArray *)images
       progressBlock:(void(^)(int index, float progress))progressBlock
              result:(void(^)(NSArray *array, BOOL isSuccessfule, NSError *error))block
{
    NSMutableArray *datas = @[].mutableCopy;
    for (UIImage *image in images) {
        NSString *imageName =[NSString stringWithFormat:@"%@.jpg",[NSString createUUID]];
        NSData *data = UIImageJPEGRepresentation(image, 0.9);
        NSDictionary *dict = @{@"filename":imageName,@"data":data};
        [datas addObject:dict];
    }
    [BmobFile filesUploadBatchWithDataArray:datas progressBlock:^(int index, float progress) {
        progressBlock(index, progress);
    } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
        
        //block(array,isSuccessful,error);
        if (!isSuccessful) {
            return ;
        }
        NSMutableArray *urls = @[].mutableCopy;
        for (BmobFile *file in array) {
            [urls addObject:file.url];
        }
        block(urls,isSuccessful,error);
        
    }];
}

+ (void)requestCloudAPI:(NSString *)apiName paramerters:(NSDictionary *)parameters block:(void (^)(id result, NSError *error))result
{
    [BmobCloud callFunctionInBackground:apiName withParameters:parameters block:^(id object, NSError *error) {
        result(object, error);
        
    }];

}


@end
