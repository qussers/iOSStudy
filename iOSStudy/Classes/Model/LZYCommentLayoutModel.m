//
//  LZYCommentLayoutModel.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/28.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYCommentLayoutModel.h"
#import "LZYCommentModel.h"
#import "LZYGlobalDefine.h"
#import "NSString+LZYAdd.h"
#import "LZYCommentTableViewCell.h"
@implementation LZYCommentLayoutModel

- (instancetype)initWithModel:(LZYCommentModel *)model
{
    if (self = [super init]) {
        [self setupWithModel:model];
    }
    return self;
}

- (void)setupWithModel:(LZYCommentModel *)model
{
    self.model = model;
    self.iconFrame = CGRectMake(8, 8, 40, 40);
    self.userNameLabelFrame = CGRectMake(CGRectGetMaxX(self.iconFrame) + 8, 8, [model.user.username stringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) fontSize:17].width, 25);
    self.timeLabelFrame = CGRectMake(CGRectGetMaxX(self.iconFrame) + 8, CGRectGetMaxY(self.userNameLabelFrame), 200, 30);
    NSString *realContent = [model.content stringByReplacingOccurrencesOfString:@"<herf>" withString:@""];
    realContent = [realContent stringByReplacingOccurrencesOfString:@"</herf>" withString:@""];
    self.contentLabelFrame = CGRectMake(CGRectGetMaxX(self.iconFrame) + 8, CGRectGetMaxY(self.iconFrame) + 8, LZYSCREEN_WIDTH - CGRectGetWidth(self.iconFrame) - 16, [realContent stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - CGRectGetWidth(self.iconFrame) - 16, CGFLOAT_MAX) fontSize:15].height + 8);
    
    self.imagesScrollViewFrame = CGRectMake(self.contentLabelFrame.origin.x, CGRectGetMaxY(self.contentLabelFrame) + 8, CGRectGetWidth(self.contentLabelFrame) - 8, 44);
    if (model.images.count > 0) {
          self.rewardBtnFrame = CGRectMake(LZYSCREEN_WIDTH - 100, CGRectGetMaxY(self.imagesScrollViewFrame) + 8, 100, 30);
    }
    else{
        self.rewardBtnFrame = CGRectMake(LZYSCREEN_WIDTH - 100, CGRectGetMaxY(self.contentLabelFrame) + 8, 100, 30);
    }

    self.cellFrame = CGRectMake(0, 0, LZYSCREEN_WIDTH, CGRectGetMaxY(self.rewardBtnFrame) + 8);
}
@end
