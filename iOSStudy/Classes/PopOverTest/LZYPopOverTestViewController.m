//
//  LZYPopOverTestViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYPopOverTestViewController.h"

@interface LZYPopOverTestViewController () <UIPopoverPresentationControllerDelegate>


@end

@implementation LZYPopOverTestViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        //self.popoverPresentationController.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing  _Nonnull *)view
//{
//
//    
//}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

@end
