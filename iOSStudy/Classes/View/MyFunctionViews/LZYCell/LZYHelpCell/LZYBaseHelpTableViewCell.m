//
//  LZYBaseHelpTableViewCell.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBaseHelpTableViewCell.h"
#import "LZYHelpModel.h"
#import "LZYGlobalDefine.h"
#import "NSString+LZYAdd.h"
@implementation LZYBaseHelpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconClicl:)];
    UITapGestureRecognizer *tapHelp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(helpClick:)];
    
    self.userIconImageView.userInteractionEnabled = YES;
    [self.userIconImageView addGestureRecognizer:tap];
    [self.tooBarView addGestureRecognizer:tapHelp];
    
    for (UIImageView *imageView in self.imageViewsContaonerView.subviews) {
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:imageTap];
    }
    
    //头像圆角
    self.userIconImageView.layer.masksToBounds = YES;
    self.userIconImageView.layer.cornerRadius = CGRectGetWidth(self.userIconImageView.frame) / 2.0;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (void)addHeightToCellModel:(NSArray *)models
{
    CGFloat scale = (LZYSCREEN_WIDTH - 20) / 355.0;
    for (LZYHelpModel *model in models) {
        //固定
        CGFloat staticHeight = 43;
        //缩放
        CGFloat changeHeight = 57 * scale;
        switch (model.images.count) {
            case 0:
            {
                changeHeight = changeHeight + 1 + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                model.tooBarYCons = 8;
            }
                break;
                
            case 1:
            {
                changeHeight = changeHeight + 209 * scale + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
              
                model.tooBarYCons = 8;
            }
                break;
            case 2:
            {
                changeHeight = changeHeight + 135 * scale + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                
                model.tooBarYCons = 8;
            }
                break;
            case 4:
            {
                changeHeight = changeHeight + 258 * scale + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                
                model.tooBarYCons = 8;
            }
                break;
            case 3:
            {
                changeHeight = changeHeight + 111 * scale + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                model.tooBarYCons = 8 - 111 * 2 * scale - 6;
            }
                break;
            case 5:
            {
                changeHeight = changeHeight + 225 * scale + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                model.tooBarYCons = 8 - 111 * scale - 3;
                
            }
                break;
            case 6:
            {
                changeHeight = changeHeight +  225 * scale + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                
                 model.tooBarYCons = 8 - 111 * scale - 3;
            }
                break;
            case 7:
            {
                changeHeight = changeHeight + 339 * scale+ [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                
                model.tooBarYCons = 8;
            }
                break;
            case 8:
            {
                changeHeight = changeHeight + 339 * scale+ [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                
                model.tooBarYCons = 8;
            }
                break;
            case 9:
            {
                changeHeight = changeHeight + 339 * scale + [model.content stringWithMaxSize:CGSizeMake(LZYSCREEN_WIDTH - 20, MAXFLOAT) fontSize:15].height;
                
                model.tooBarYCons = 8;
            }
                break;
            
            default:
                break;
        }
        model.cellHeight = staticHeight + changeHeight;
    }
}

- (IBAction)userIconClicl:(UITapGestureRecognizer *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickUser:)]) {
        
        [self.delegate cellDidClickUser:self];
    }
}



- (IBAction)helpClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickHelp:)]) {
        
        [self.delegate cellDidClickHelp:self];
    }
}




- (IBAction)imageClick:(UITapGestureRecognizer *)sender {
    
    NSInteger index = sender.view.tag - 1;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didClickImageWithIndex:)]) {
        
        [self.delegate cell:self didClickImageWithIndex:index];
    }
    
    
}




@end
