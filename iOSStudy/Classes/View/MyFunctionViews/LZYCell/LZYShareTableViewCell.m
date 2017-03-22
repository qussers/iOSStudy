//
//  LZYShareTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/1.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYShareTableViewCell.h"
#import "LZYShareModel.h"
#import "NSString+LZYAdd.h"
#import "LZYGlobalDefine.h"
#import "UIImageView+LZYWebCache.h"
#import "UIButton+LZYWebCache.h"
@implementation LZYShareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.userIconBtn.layer.masksToBounds = YES;
    self.userIconBtn.layer.cornerRadius = CGRectGetWidth(self.userIconBtn.frame) / 2.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (void)configeCellHeightWithModel:(LZYShareModel *)model
{
    
    model.cellHeight = 121 + 75 * (LZYSCREEN_WIDTH - 16) / 359.0 + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 16, CGFLOAT_MAX) fontSize:17].height;

}

- (void)configeCellWithModel:(LZYShareModel *)model
{
    self.userNameLabel.text = model.user.username;
    self.contentLabel.text = model.content;
    self.urlDescribeLabel.text = model.urlDescribe;
    [self.userIconBtn lzy_setImageWithURL:@"http://touxiang.qqzhi.com/uploads/2012-11/1111104151660.jpg"];
    [self.urlImageView lzy_setImageWithURL:model.urlImageUrl];
    
}


- (IBAction)commentBtnClick:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickComment:)]) {
        [self.delegate cellDidClickComment:self];
    }
    
    
}


- (IBAction)rewordBtnClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickReword:)]) {
        [self.delegate cellDidClickReword:self];
    }
}

- (IBAction)userIconClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickUser:)]) {
        [self.delegate cellDidClickUser:self];
    }
}

@end
