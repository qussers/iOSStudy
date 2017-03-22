//
//  LZYMoreButtonTableViewCell.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZYMoreButtonTableViewCell;

@protocol LZYMoreButtonTableViewCellDelegate <NSObject>

//点击了第index个按钮
- (void)cell:(LZYMoreButtonTableViewCell *)cell didClickButtonIndex:(NSInteger)index;

@end

@interface LZYMoreButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@property (weak, nonatomic) id<LZYMoreButtonTableViewCellDelegate> delegate;


+ (CGFloat)cellHeight;


@end
