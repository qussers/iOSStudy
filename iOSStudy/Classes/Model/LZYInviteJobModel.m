//
//  LZYInviteJobModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYInviteJobModel.h"

@implementation LZYInviteJobModel
- (instancetype)initFromBmobObject:(BmobObject *)obj
{
    if (self = [super initFromBmobObject:obj]) {
        _cityName = [obj objectForKey:@"cityName"];
        _townName = [obj objectForKey:@"townName"];
        _jobTitle = [obj objectForKey:@"jobTitle"];
        _experience = [obj objectForKey:@"experience"];
        _companyName = [obj objectForKey:@"companyName"];
        _companyType = [obj objectForKey:@"companyType"];
        _inviteName = [obj objectForKey:@"inviteName"];
        _invitePosition = [obj objectForKey:@"invitePosition"];
        _salary = [obj objectForKey:@"salary"];
        _inviteUserId = [obj objectForKey:@"inviteUserId"];
    }
    
    return self;
}
@end
