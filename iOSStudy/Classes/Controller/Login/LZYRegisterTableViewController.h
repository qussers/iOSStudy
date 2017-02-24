//
//  LZYRegisterTableViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZYRegisterTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *smsTextField;

@property (weak, nonatomic) IBOutlet UIButton *smsButton;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField2;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
