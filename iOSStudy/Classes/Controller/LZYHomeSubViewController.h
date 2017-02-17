//
//  LZYHomeSubViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseViewController.h"

@interface LZYHomeSubViewController : LZYBaseViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;


@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, copy) NSString *subjectTag;

@end
