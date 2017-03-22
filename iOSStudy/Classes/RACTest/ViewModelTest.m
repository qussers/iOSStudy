
//
//  ViewModelTest.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "ViewModelTest.h"

@implementation ViewModelTest

- (instancetype)init
{
    if (self = [super init]) {
        
        _testSingle = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSLog(@"有人订阅我哦哦哦哦哦~~~~~");
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                
                NSLog(@"我是订阅完成了哦哦哦哦哦哦");
            }];
        }];
        
        
        _testSubject = [RACSubject subject];
        [_testSubject sendCompleted];
        
        
    }
    
    return self;
}


- (RACSignal *)testSingle
{
    if (!_testSingle) {
        _testSingle = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"我是测试信号啦啦啦啦啦了"];
            return nil;
        }];
    }
    
    return _testSingle;

}
@end
