//
//  LZYNewsLeftImageTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZYNewsLeftImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;



+ (CGFloat)cellHeight;
@end
