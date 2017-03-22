//
//  LZYInviteJobTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZYInviteJobTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *jobTitle;

@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *townNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *academicLabel;

@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *inviteUserImageView;

@property (weak, nonatomic) IBOutlet UILabel *inviteUserName;


@property (weak, nonatomic) IBOutlet UILabel *inviteUserPositon;


@end
