//
//  LZYUserModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYUserModel.h"

@implementation LZYUserModel
- (instancetype)initFromBmobObject:(BmobObject *)obj
{
    if (self = [super initFromBmobObject:obj]) {
        _userIcon = [obj objectForKey:@"userIcon"];
    }
    return self;
}


+ (instancetype)getCurrentUser
{
    if ([super getCurrentUser]) {
        LZYUserModel *user = [[LZYUserModel alloc] initFromBmobObject:[super getCurrentUser]];
        return user;
    }
    return nil;
}
@end
