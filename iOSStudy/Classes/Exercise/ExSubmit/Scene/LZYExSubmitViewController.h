//
//  LZYExSubmitViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseViewController.h"
#import <ReactiveObjC.h>
@interface LZYExSubmitViewController : LZYBaseViewController

- (instancetype)initWithData:(NSArray *)data;

//点击了解析的回调
@property (nonatomic, strong) RACSubject *parseClickSubject;

//普通回调
@property (nonatomic, strong) RACSubject *overViewClickSubject;

@end
