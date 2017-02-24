//
//  LZYInterviewModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYInterviewModel.h"

@implementation LZYInterviewModel

- (instancetype)initFromBmobObject:(BmobObject *)obj
{
    if (self = [super initFromBmobObject:obj]) {
        _companyName = [obj objectForKey:@"companyName"];
        _tagArr = [obj objectForKey:@"tagArr"];
        _interviewContent = [obj objectForKey:@"interviewContent"];
        _commentCount = [[obj objectForKey:@"commentCount"] integerValue];
        _jobTitle = [obj objectForKey:@"jobTitle"];
        _likes = [[obj objectForKey:@"likes"] integerValue];
        _interviewUserName = [obj objectForKey:@"interviewUserName"];
    }
    
    return self;
}
@end
