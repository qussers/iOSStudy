//
//  LZYNetwork.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>


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

@end
