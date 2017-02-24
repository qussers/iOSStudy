//
//  LZYEditInterviewViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseTableViewController.h"

@interface LZYEditInterviewViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *companyCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *jobTitleCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *interviewFleeCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *interviewContentCell;


@property (weak, nonatomic) IBOutlet UITextField *companyNameText;


@property (weak, nonatomic) IBOutlet UITextField *jobTitleText;


@property (weak, nonatomic) IBOutlet UITextView *interviewContentTextView;




@end
