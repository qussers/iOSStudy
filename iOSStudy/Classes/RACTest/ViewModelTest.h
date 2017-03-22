//
//  ViewModelTest.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
@interface ViewModelTest : NSObject

@property (nonatomic, strong) RACSignal *testSingle;


@property (nonatomic, strong) RACSubject *testSubject;

@end
