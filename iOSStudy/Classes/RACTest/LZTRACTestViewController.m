//
//  LZTRACTestViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZTRACTestViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TextView1.h"
@interface LZTRACTestViewController ()

//创建一个信号成员变量
@property (nonatomic, strong) RACSignal *test1Signal;

@property (nonatomic, strong) ViewModelTest *model;

@property (nonatomic, strong) TextView1 *testBtn1;

@end

@implementation LZTRACTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _model = [[ViewModelTest alloc] init];
 
    
    
    _testBtn1 = [[TextView1 alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    
    
    [self.view addSubview:_testBtn1];
    
    
    [[self.testBtn1 rac_signalForSelector:@selector(btnClick)] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"我去 我可以拿到你的按钮点击事件了！！！！很神奇有没有");
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnclick:(id)sender {
    
    
    [self test2];
}



- (void)test
{

    RACMulticastConnection *connection = [self.model.testSingle publish];
    
    
    //订阅信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"订阅一发试一试 看看有没有什么东西~~~~~");
    }];
    
    [connection.signal subscribeCompleted:^{
       
        NSLog(@"订阅完成状态哦~~~~~");
    }];
    
    //连接信号
    [connection connect];
}


- (void)test2
{

    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}


- (void)test3
{
    
  

}
@end
