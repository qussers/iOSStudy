//
//  LZYDynamicViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYDynamicViewController.h"
#import "LZYNearChatViewController.h"
#import "LZYFunctionViewController.h"

//编辑面试经验页面
#import "LZYEditInterviewViewController.h"

//编辑招聘信息页面
#import "LZYEditInviteJobViewController.h"


@interface LZYDynamicViewController ()

//最近下次列表
@property (nonatomic, strong) LZYNearChatViewController *nearViewController;

@property (nonatomic, strong) LZYFunctionViewController *functionViewController;

@end

@implementation LZYDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//针对首页视图显示和隐藏tabbar设置
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}



- (void)setup
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:self.functionViewController];
    [self addChildViewController:self.nearViewController];
    self.functionViewController.view.frame = self.view.bounds;
    self.nearViewController.view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    [self.view addSubview:self.functionViewController.view];
}


- (IBAction)editButtonClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择编辑类型" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"求助" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"editHelpNavController"];
        [self presentViewController:nav animated:YES completion:nil];
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        NSLog(@"点击了娱乐");
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"面试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        LZYEditInterviewViewController *v = [storyboard instantiateViewControllerWithIdentifier:@"editInterviewController"];
        [self.navigationController pushViewController:v animated:YES];
    }]];
    

    
    [alert addAction:[UIAlertAction actionWithTitle:@"招聘" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        UINavigationController *v = [storyboard instantiateViewControllerWithIdentifier:@"editInviteJobNavController"];
        [self presentViewController:v animated:YES completion:nil];
    }]];
    

    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        NSLog(@"点击了取消");
    }]];
    
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
    


    
}

- (IBAction)segmentClick:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [self changeToFunctionView];
        }
            break;
        case 1:
        {
            [self changeToChatView];
        }
            break;
        default:
            break;
    }
    
    
}

- (void)changeToFunctionView
{
    [self.nearViewController.view removeFromSuperview];
    
    if (![self.view.subviews containsObject:self.functionViewController.view]) {
        [self.view addSubview:self.functionViewController.view];
    }
    
     [self.view bringSubviewToFront:self.functionViewController.view];
}

- (void)changeToChatView
{
    
    [self.functionViewController.view removeFromSuperview];

    if (![self.view.subviews containsObject:self.nearViewController.view]) {
        [self.view addSubview:self.nearViewController.view];
    }
    
    [self.view bringSubviewToFront:self.nearViewController.view];

}


#pragma mark - lazy

- (LZYNearChatViewController *)nearViewController
{
    if (!_nearViewController) {
        _nearViewController = [[LZYNearChatViewController alloc] init];
    }
    return _nearViewController;
}

- (LZYFunctionViewController *)functionViewController
{
    if (!_functionViewController) {
        _functionViewController = [[LZYFunctionViewController alloc] init];
    }
    return _functionViewController;
}

@end
