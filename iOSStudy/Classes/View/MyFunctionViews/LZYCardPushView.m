//
//  LZYCarkPushView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/19.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYCardPushView.h"

@interface LZYCardPushView ()

@property (nonatomic, strong) NSMutableArray *cardsViewStore;

@property (nonatomic, assign) CGPoint originalCenter;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, assign) CGRect cardViewFrame;

@end

@implementation LZYCardPushView

CGFloat firstCardViewGap = 15;
CGFloat cardGap = 8;
NSInteger defaultPageNumber = 3;



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self firstLoadView];
    }
    [self layoutIfNeeded];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self firstLoadView];
    }
    [self layoutIfNeeded];
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //根据真实frame更新
    if (!CGRectEqualToRect(self.cardViewFrame, self.frame)) {
        self.cardViewFrame = self.frame;
        [self layoutItemViews];
    }
}

- (void)layoutItemViews
{
    for (int i = 0; i < self.cardsViewStore.count; i++) {
        UIView *v = self.cardsViewStore[i];
        if (i == 0) {
            v.frame = CGRectMake(firstCardViewGap, firstCardViewGap, self.frame.size.width - 2 * firstCardViewGap, self.frame.size.height - firstCardViewGap * 4);
        }
        else{
            UIView *lastView = self.cardsViewStore[i-1];
            v.frame = CGRectMake(lastView.frame.origin.x + cardGap, lastView.frame.origin.y + cardGap, lastView.frame.size.width - 2 * cardGap, lastView.frame.size.height);
        }
        if (self.dataSource && v.subviews.count == 1) {
            UIView *subView = [v.subviews firstObject];
            subView.frame = v.bounds;
                switch (i) {
                    case 0:
                        subView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
                        break;
                    case 1:
                        subView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
                        break;
                    case 2:
                        subView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
                        break;
                    default:
                        break;
                }
                [v addSubview:subView];
        }
        
    }
}
- (void)firstLoadView
{
    if (self.dataSource) {
        NSInteger page = [self.dataSource numberOfCardsWithPushView:self] ;
        self.totalPage = page;
        for (int i = 0; i < (page < defaultPageNumber ? page: defaultPageNumber); i++) {
            [self createBaseViewWithIndex:i];
        }
    }
}

- (void)reloadData
{
    for (UIView *v in self.cardsViewStore) {
        [v removeFromSuperview];
    }
    [self.cardsViewStore removeAllObjects];
    self.originalCenter = CGPointZero;
    self.currentIndex = 0;
    self.totalPage = 0;
    [self firstLoadView];
}

- (void)createBaseViewWithIndex:(NSInteger)index
{
    UIView *newView = [[UIView alloc] init];
    if (self.cardsViewStore.count > 0) {
        UIView *lastView = self.cardsViewStore.lastObject;
        newView.frame = CGRectMake(lastView.frame.origin.x + cardGap, lastView.frame.origin.y + cardGap, lastView.frame.size.width - 2 * cardGap, lastView.frame.size.height);
        [self insertSubview:newView belowSubview:lastView];
    }
    else{
         newView.frame = CGRectMake(firstCardViewGap, firstCardViewGap, self.cardViewFrame.size.width - 2 * firstCardViewGap, self.cardViewFrame.size.height - firstCardViewGap * 4);
        [self addSubview:newView];
    }
    newView.layer.masksToBounds = YES;
    newView.layer.cornerRadius = 4;
    [self addGestureWithView:newView];
    [self.cardsViewStore addObject:newView];
    if (self.dataSource && CGRectEqualToRect(self.cardViewFrame, self.frame) && newView.subviews.count == 0) {
        UIView *subView = [self.dataSource cardPushView:self index:index];
        subView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        if (subView) {
            subView.frame = newView.bounds;
            [newView addSubview:subView];
        }
    }
}

- (void)addGestureWithView:(UIView *)v
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [v addGestureRecognizer:pan];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    UIView *v = self.cardsViewStore.firstObject;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalCenter = v.center;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint movePoint = [pan translationInView:v];
            v.center = CGPointMake(v.center.x + movePoint.x, v.center.y + movePoint.y);
            CGFloat angle = (v.center.x - v.frame.size.width / 2.0) / v.frame.size.width * 0.5;
            v.transform = CGAffineTransformMakeRotation(angle);
            [pan setTranslation:CGPointZero inView:v];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (ABS(v.center.x - self.originalCenter.x) > (v.frame.size.width / 5.0)) {
                [self removeView];
            }
            else{
                [UIView animateWithDuration:0.3 animations:^{
                    v.center = self.originalCenter;
                    v.transform = CGAffineTransformMakeRotation(0);
                }];
            }
        }
            break;
        default:
            break;
    }
}

- (void)removeView
{
    UIView *v = self.cardsViewStore.firstObject;
    [UIView animateWithDuration:0.3 animations:^{
        if (v.frame.origin.x > 0) {
            v.center = CGPointMake(v.frame.size.width * 2, v.frame.size.height / 2.0);
        }
        else{
            v.center = CGPointMake(-v.frame.size.width, v.frame.size.height / 2.0);
        }
    } completion:^(BOOL finished) {
        [self setUpNewFrame];
    }];
}

- (void)setUpNewFrame
{
    UIView *fv = self.cardsViewStore.firstObject;
    [UIView animateWithDuration:0.15 animations:^{
        for (int i = 0; i < self.cardsViewStore.count; i ++) {
            if (i > 0) {
                UIView *v = self.cardsViewStore[i];
                v.frame = CGRectMake(v.frame.origin.x - cardGap, v.frame.origin.y - cardGap, v.frame.size.width + cardGap * 2, v.frame.size.height);
                if (i == 1) {
                    [v.subviews firstObject].backgroundColor = [UIColor colorWithWhite:1 alpha:1];
                }
                else if(i == 2){
                    [v.subviews firstObject].backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
                }
                
            }
            
        }
    } completion:^(BOOL finished) {
        [fv removeFromSuperview];
        [self.cardsViewStore removeObject:fv];
        self.currentIndex++;
        if (self.currentIndex < self.totalPage - 1) {
           [self createBaseViewWithIndex:self.currentIndex - 1  + (self.totalPage < defaultPageNumber ? self.totalPage : defaultPageNumber)];
        }
        
    }];
}

#pragma mark - lazy
- (NSMutableArray *)cardsViewStore
{
    if (!_cardsViewStore) {
        _cardsViewStore = @[].mutableCopy;
    }
    return _cardsViewStore;
}

- (void)setDataSource:(id<LZYCardPushViewDataSource>)dataSource
{
    if (_dataSource != dataSource)
    {
        _dataSource = dataSource;
        if (_dataSource)
        {
            [self reloadData];
        }
    }
}

@end
