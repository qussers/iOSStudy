//
//  LZYInterviewTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYInterviewTableViewCell.h"
#import "NSString+LZYAdd.h"
#import "LZYGlobalDefine.h"
#import "LZYInterviewModel.h"
@implementation LZYInterviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)loadMoreClick:(id)sender {
    
    if(self.loadMoreContentClick){
        if ([self.interviewContentLabel.constraints containsObject:self.interviewHeightConstraint]) {
            self.loadMoreContentClick(YES);
        }else{
            self.loadMoreContentClick(NO);
        }
    }
    
}



+ (CGFloat)labelHeightWithLabelContent:(NSString *)content
{
    CGFloat labelHeight = [content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 30, MAXFLOAT)  fontSize:14].height;
    
    return labelHeight;
}


+ (BOOL)labelHeigherThanStandardWithContent:(NSString *)content
{
    if ([self labelHeightWithLabelContent:content] > 50) {
        return YES;
    }
    else{
        return NO;
    }
}


+ (void)cellHeightWithContent:(NSString *)content model:(LZYInterviewModel *)model
{
    CGFloat labelHeight = [self labelHeightWithLabelContent:content];
    
    
    if (labelHeight > 50) {
        model.cellHeight =  (57 + 24 + 32 + 22) * ((LZYSCREEN_WIDTH - 30) / 345.0) + (145 - (57 + 24 + 32 + 22)) + 50 + 10;
        model.totalCellHeight = labelHeight + model.cellHeight - 50;
        model.isWordBreak = YES;
    }
    else{
        model.cellHeight = (57 + 24 + 32) * ((LZYSCREEN_WIDTH - 30) / 345.0) + (145 - (57 + 24 + 32 + 22 ))+ labelHeight + 10;
        model.totalCellHeight = model.cellHeight;
        model.isWordBreak = NO;
    }
    
    
}





@end
