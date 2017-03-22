//
//  LZYSecondSubjectTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYSecondSubjectTableViewCell.h"

@implementation LZYSecondSubjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configeWithDifficult:(NSInteger)difficult
{
    [self.firstStar setHidden:YES];
    [self.secondStar setHidden:YES];
    [self.thirdStar setHidden:YES];
    [self.fouthStar setHidden:YES];
    [self.fifthStar setHidden:YES];
    
    //穿透赋值
    switch (difficult) {
        case 5:
            [self.firstStar setHidden:NO];
        case 4:
            [self.fouthStar setHidden:NO];
        case 3:
            [self.thirdStar setHidden:NO];
        case 2:
            [self.secondStar setHidden:NO];
        case 1:
            [self.firstStar setHidden:NO];
            break;
        default:
            break;
    }
}

@end
