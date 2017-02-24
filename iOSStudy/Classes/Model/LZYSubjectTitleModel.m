//
//  LZYSubjectTitleModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSubjectTitleModel.h"

@implementation LZYSubjectTitleModel

- (instancetype)initFromBmobObject:(BmobObject *)obj
{
    if (self = [super initFromBmobObject:obj]) {
        _subTitle = [obj objectForKey:@"title"];
        _color = [obj objectForKey:@"color"];
    }
    return self;
}

@end
