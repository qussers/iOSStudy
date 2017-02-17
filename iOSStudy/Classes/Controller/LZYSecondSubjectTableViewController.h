//
//  LZYSecondSubjectTableViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseTableViewController.h"

typedef NS_ENUM(NSInteger, subjectContentType) {
    kKnowledge,
    kQuestion
};

@interface LZYSecondSubjectTableViewController : LZYBaseTableViewController

@property (nonatomic, copy) NSString *subjectTag;

@property (nonatomic, assign) subjectContentType contentType;

@end
