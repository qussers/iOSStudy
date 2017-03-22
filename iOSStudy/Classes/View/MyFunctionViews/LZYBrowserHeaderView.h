//
//  LZYBrowserHeaderView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZYBrowserHeaderViewDelegate <NSObject>

- (void)searchButtonClickWithSearchUrl:(NSString *)url;

@end

@interface LZYBrowserHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *bottomButtonsView;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (nonatomic, strong) NSArray *tabTitles;

@property (nonatomic, copy) NSString *baseSearchUrl;

@property (nonatomic, weak) id<LZYBrowserHeaderViewDelegate>delegate;

@end
