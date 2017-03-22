//
//  LZYSubjectContentViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSubjectContentViewController.h"

#import "LZYGlobalDefine.h"
@interface LZYSubjectContentViewController ()



@end

@implementation LZYSubjectContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}




@end
