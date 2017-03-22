//
//  LZYBmobQueryTypeModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSInteger, queryType) {
    kEqual,
    kNotEqual,
    kLessThan,
    kLessThanOrEqual,
    kGreater,
    kGreaterThanOrEqual,
    kIncludeKey
};

@interface LZYBmobQueryTypeModel : NSObject

//字段名
@property (nonatomic, copy) NSString *queryKeyName;

//查询的条件方式
@property (nonatomic, assign) queryType type;

//要比较的值
@property (nonatomic, strong) id queryValue;

- (instancetype)initWithQueryKeyName:(NSString *)queryKeyName
                           queryType:(queryType)type
                            disValue:(id)queryValue;

@end
