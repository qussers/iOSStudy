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

#import "LZYSubjectTitleModel.h"
#import "LZYSecondSubjectModel.h"

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
                model.subTitle = [obj objectForKey:@"title"];
                model.color = [obj objectForKey:@"color"];
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
                model.answerUrl = [obj objectForKey:@"content"];
                model.subjectTitle = [obj objectForKey:@"title"];
                model.subjectTag = [obj objectForKey:@"subject_tag"];
                model.tag  = [obj objectForKey:@"tag"];
                model.difficult = [[obj objectForKey:@"difficult"] integerValue];
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
@end
