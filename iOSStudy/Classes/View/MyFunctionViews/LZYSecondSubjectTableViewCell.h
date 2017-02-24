//
//  LZYSecondSubjectTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZYSecondSubjectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTagLabel;

@property (weak, nonatomic) IBOutlet UIImageView *firstStar;

@property (weak, nonatomic) IBOutlet UIImageView *secondStar;

@property (weak, nonatomic) IBOutlet UIImageView *thirdStar;

@property (weak, nonatomic) IBOutlet UIImageView *fouthStar;

@property (weak, nonatomic) IBOutlet UIImageView *fifthStar;

- (void)configeWithDifficult:(NSInteger)difficult;

@end
