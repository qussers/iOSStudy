//
//  LZYBrowserToolBarView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZYBrowserToolBarViewDelegate <NSObject>

- (void)browserToolBarClickWithIndex:(NSInteger)index;

@end

@interface LZYBrowserToolBarView : UIView

@property (nonatomic, weak) id<LZYBrowserToolBarViewDelegate> delegate;

@end
