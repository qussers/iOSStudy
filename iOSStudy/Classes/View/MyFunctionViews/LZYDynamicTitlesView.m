//
//  LZYDynamicTitlesView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYDynamicTitlesView.h"
#import "LZYGlobalDefine.h"

#import "UIColor+LZYAdd.h"
@interface LZYDynamicSubTitleView()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *redPointView;


@end


@implementation LZYDynamicSubTitleView

CGFloat gap = 20;

CGFloat redPointWidth = 3;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    [self addSubview:self.titleLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidClick:)];
    
    [self addGestureRecognizer:tap];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}


- (void)hasNewNotification
{
    if (!_redPointView) {
        _redPointView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, gap, redPointWidth, redPointWidth)];
        _redPointView.layer.masksToBounds = YES;
        _redPointView.layer.cornerRadius = redPointWidth / 2.0;
        _redPointView.backgroundColor = [UIColor redColor];
        [self addSubview:_redPointView];
    }
}

- (void)removeNotification
{
    if (_redPointView) {
        [_redPointView removeFromSuperview];
        _redPointView = nil;
    }
}

- (void)viewDidClick:(UITapGestureRecognizer *)tap
{
    if (self.dynamicSubTitleDidClick) {
        self.dynamicSubTitleDidClick(self);
    }
}

#pragma mark - lazy

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(gap, gap, self.frame.size.width - 2 * gap, self.frame.size.height - 2 * gap)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}

@end


@interface LZYDynamicTitlesView()



@property (nonatomic, strong) NSMutableArray *titleViews;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation LZYDynamicTitlesView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
    }
    return self;
}


- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (self.subviews.count > 0) {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        [self.titleViews removeAllObjects];
    }
    
    [self createSubView];
}


- (void)createSubView
{
    for (int i = 0; i < self.titles.count; i++) {
        
        LZYDynamicSubTitleView *subView = [[LZYDynamicSubTitleView alloc] initWithFrame:CGRectMake(i * self.frame.size.width / self.titles.count, 0, self.frame.size.width / self.titles.count, self.frame.size.height - 2)];
        subView.title = self.titles[i];
        subView.tag = i + 100;
        __weak typeof(self)weakSelf = self;
        subView.dynamicSubTitleDidClick = ^(LZYDynamicSubTitleView *clickView){
            __strong typeof(self)strongSelf = weakSelf;
            CGRect newFrame = CGRectMake(clickView.frame.origin.x, CGRectGetMaxY(clickView.frame), CGRectGetWidth(clickView.frame), 2);
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(dynamicTitleView:didSelected:)]) {
                [strongSelf.delegate dynamicTitleView:strongSelf didSelected:(clickView.tag - 100)];
            }
            [strongSelf changeLineViewAnimationWithFrame:newFrame];
        };

        if (i == 0) {
            self.lineView.frame = CGRectMake(0, CGRectGetMaxY(subView.frame), CGRectGetWidth(subView.frame), 2);
        }
        
        [self.titleViews addObject:subView];
        [self addSubview:subView];
    }


}

- (void)changeLineViewAnimationWithFrame:(CGRect)frame
{
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = frame;
    }];
}


- (void)hasNewNotificationViewIndex:(NSInteger)index
{
    LZYDynamicSubTitleView *v = self.titleViews[index];
    [v hasNewNotification];
}

- (void)removeNotificationWithIndex:(NSInteger)index
{
    LZYDynamicSubTitleView *v = self.titleViews[index];
    [v removeNotification];
}

#pragma mark - lazy

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:MainColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (NSMutableArray *)titleViews
{
    if (!_titleViews) {
        _titleViews = @[].mutableCopy;
    }
    
    return _titleViews;
}
@end
