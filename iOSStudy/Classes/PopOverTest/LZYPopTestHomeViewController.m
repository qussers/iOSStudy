//
//  LZYPopTestHomeViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYPopTestHomeViewController.h"
#import "LZYPopOverTestViewController.h"

@interface LZYPopTestHomeViewController ()

@end

@implementation LZYPopTestHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)popButtonClick:(id)sender {
    
    LZYPopOverTestViewController *testPopVC = [[LZYPopOverTestViewController alloc] init];
    testPopVC.popoverPresentationController.sourceView = self.btn;
    testPopVC.popoverPresentationController.sourceRect = self.btn.bounds;
    testPopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp; //箭头方向
    testPopVC.popoverPresentationController.delegate = self;
    testPopVC.view.frame = CGRectMake(0, 0, 100, 200);
    [self presentViewController:testPopVC animated:YES completion:nil];
    
}







@end
