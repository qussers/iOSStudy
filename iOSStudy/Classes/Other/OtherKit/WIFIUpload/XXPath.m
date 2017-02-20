//
//  XXPath.m
//  WifiUploadFile
//
//  Created by jiang on 16/9/18.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "XXPath.h"

static NSString *s_DocPath = nil;
static NSString *s_MusicPath = nil;

@implementation XXPath


+ (NSString *)homePath
{
	return NSHomeDirectory();
}

+ (NSString *)tempPath;
{
	return [NSTemporaryDirectory() stringByStandardizingPath];
}

+ (NSString *)docPath
{
    if (s_DocPath == nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        s_DocPath = paths[0];
    }
    return s_DocPath;
}

+ (NSString *)privatePath
{
    return [self docPath];
}

+ (NSString *)appPath
{
	return [[NSBundle mainBundle] bundlePath];
}
@end
