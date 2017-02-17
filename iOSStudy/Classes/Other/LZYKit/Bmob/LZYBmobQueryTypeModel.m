//
//  LZYBmobQueryTypeModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBmobQueryTypeModel.h"

@implementation LZYBmobQueryTypeModel
- (instancetype)initWithQueryKeyName:(NSString *)queryKeyName
                           queryType:(queryType)type
                            disValue:(id)queryValue
{
    if (self = [super init]) {
        _queryKeyName = queryKeyName;
        _type = type;
        _queryValue = queryValue;
    }
    return self;
}
@end
