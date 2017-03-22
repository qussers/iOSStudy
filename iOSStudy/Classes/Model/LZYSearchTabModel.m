//
//  LZYSearchTabModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSearchTabModel.h"

@implementation LZYSearchTabModel

- (instancetype)initFromBmobObject:(BmobObject *)obj
{
    if (self = [super initFromBmobObject:obj]) {
        _title = [obj objectForKey:@"title"];
        _domainName = [obj objectForKey:@"_domainName"];
    }
    return self;
}

@end
