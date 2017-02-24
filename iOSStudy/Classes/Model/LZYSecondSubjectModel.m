//
//  LZYSecondSubjectModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSecondSubjectModel.h"

@implementation LZYSecondSubjectModel

- (instancetype)initFromBmobObject:(BmobObject *)obj
{
    if (self = [super initFromBmobObject:obj]) {
        _answerUrl = [obj objectForKey:@"content"];
        _subjectTitle = [obj objectForKey:@"title"];
        _subjectTag = [obj objectForKey:@"subject_tag"];
        _tag  = [obj objectForKey:@"tag"];
        _difficult = [[obj objectForKey:@"difficult"] integerValue];
    }
    return self;
}

@end
