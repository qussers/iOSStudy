//
//  LZYCommentTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/28.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYCommentTableViewCell.h"
#import "LZYCommentLayoutModel.h"
#import "LZYCommentModel.h"
#import "NSString+LZYAdd.h"
#import "UIImageView+LZYWebCache.h"
#import "UIButton+LZYWebCache.h"
#import <YYKit.h>
#import "LZYGlobalDefine.h"
@implementation LZYCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setup
{
    _topLine = [UIView new];
    _topLine.backgroundColor = [UIColor lightGrayColor];
    _topLine.frame = CGRectMake(0, 0, LZYSCREEN_WIDTH, 1);
    
    _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.exclusiveTouch = YES;
    _iconBtn.backgroundColor = [UIColor redColor];
    
    _userNameLabel = [YYLabel new];
    _timeLabel = [YYLabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13.0];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _answerLabel = [YYLabel new];
    _contentLabel = [YYLabel new];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
     _imagesScrollView = [[UIScrollView alloc] init];
    
    //创建9张imageView
    for (int i = 0; i < 9;  i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i + 1;
        [self.images addObject:imageView];
        [_imagesScrollView addSubview:imageView];
        __weak typeof(self)weakSelf = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
            if([weakSelf.delegate respondsToSelector:@selector(cell:didClickImageWithIndex:)]){
                [weakSelf.delegate cell:weakSelf didClickImageWithIndex:i];
            }
            
        }];
        [imageView addGestureRecognizer:tap];
    }
    
    _rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rewardBtn.exclusiveTouch = YES;
    [self.rewardBtn setTitle:@"打赏" forState:UIControlStateNormal];
    [self.rewardBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_topLine];
    [self.contentView addSubview:_iconBtn];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_answerLabel];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_imagesScrollView];
    [self.contentView addSubview:_rewardBtn];

    __weak typeof(self)weakSelf = self;
    [_iconBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if([weakSelf.delegate respondsToSelector:@selector(cellDidClickUserIcon:)]){
            [weakSelf.delegate cellDidClickUserIcon:weakSelf];
        }
    }];
    
    
    [_rewardBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if ([weakSelf.delegate respondsToSelector:@selector(cellDidClickReword:)]) {
            [weakSelf.delegate cellDidClickReword:weakSelf];
        }
    }];
    
}


- (void)configeCellWithLayoutModel:(LZYCommentLayoutModel *)layout
{
    self.iconBtn.frame = layout.iconFrame;
    [self.iconBtn lzy_setImageWithURL:[layout.model.user objectForKey:@"userIcon" ]];
    self.userNameLabel.frame = layout.userNameLabelFrame;
    self.timeLabel.frame = layout.timeLabelFrame;
    //内容处理
    self.contentLabel.frame = layout.contentLabelFrame;
    NSString *realContent = [layout.model.content stringByReplacingOccurrencesOfString:@"<herf>" withString:@""];
    realContent = [realContent stringByReplacingOccurrencesOfString:@"</herf>" withString:@""];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:realContent];
    NSArray *ranges = [layout.model.content parseToWebLink];
    if (ranges && ranges.count > 0) {
        for (int i = 0; i < ranges.count; i++) {
            NSRange range = [ranges[i] rangeValue];
            [content setTextHighlightRange:NSMakeRange(range.location - i * 11 - 6, range.length) color:[UIColor blueColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                if(self.delegate && [self.delegate respondsToSelector:@selector(cell:didClickWebUrl:)]){
                    [self.delegate cell:self didClickWebUrl:[realContent substringWithRange:range]];
                }
            }];
        }
    }
    content.font = [UIFont systemFontOfSize:15.0];
    self.contentLabel.attributedText = content;
    self.userNameLabel.text = layout.model.user.username;
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    self.timeLabel.text = [formatter stringFromDate:layout.model.createdAt];
    //图片处理
    if (layout.model.images.count > 0) {
        [self.imagesScrollView setHidden:NO];
        self.imagesScrollView.frame = layout.imagesScrollViewFrame;
        self.imagesScrollView.contentSize = CGSizeMake((CGRectGetHeight(layout.imagesScrollViewFrame) + 10) * layout.model.images.count, CGRectGetHeight(layout.imagesScrollViewFrame));
        for (int i = 0; i < 9; i++) {
            UIImageView *imageView = [self.imagesScrollView viewWithTag:(i + 1) ];
            if (i < layout.model.images.count) {
                NSString *url = layout.model.images[i];
                [imageView lzy_setImageWithURL:url];
                imageView.frame = CGRectMake(i * (CGRectGetHeight(layout.imagesScrollViewFrame) + 10), 0, CGRectGetHeight(layout.imagesScrollViewFrame), CGRectGetHeight(layout.imagesScrollViewFrame));
                   [imageView setHidden:NO];
            }
            else{
                [imageView setHidden:YES];
            }
        }
    }
    else{
        [self.imagesScrollView setHidden:YES];
    }
    
    self.rewardBtn.frame = layout.rewardBtnFrame;
}


#pragma mark - lazy
- (NSMutableArray *)images
{
    if (!_images) {
        _images = @[].mutableCopy;
    }
    return _images;
}
@end
