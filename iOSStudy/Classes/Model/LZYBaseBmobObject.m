//
//  LZYBaseBmobObject.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/24.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseBmobObject.h"

@implementation LZYBaseBmobObject

- (instancetype)initFromBmobObject:(BmobObject *)obj
{
    if (self = [super initFromBmobObject:obj]) {
        _userId = [obj objectForKey:@"userId"];
        _userIcon = [obj objectForKey:@"userIcon"];
        _userName = [obj objectForKey:@"userName"];
    }
    return self;
}
@end
