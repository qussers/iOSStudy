//
//  LZYBrowserHeaderView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBrowserHeaderView.h"
#import "LZYSearchTabModel.h"


@interface LZYBrowserHeaderView ()


//被选中的标签
@property (nonatomic, assign) NSInteger selectIndex;

@end


@implementation LZYBrowserHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _selectIndex = -1;
    }
    
    return self;

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
     
        _selectIndex = -1;
    }
    
    return self;
}


- (IBAction)touchDown:(id)sender {
    
    [self searchButtonClick:nil];
}


- (IBAction)searchButtonClick:(UIButton *)sender {
    
    NSString *searchUrl = nil;
    [self.searchTextField resignFirstResponder];
    if (self.selectIndex >= 0) {
        LZYSearchTabModel *model = self.tabTitles[self.selectIndex];
        searchUrl = model.domainName;
    }else{
         searchUrl = [NSString stringWithFormat:@"%@%@",self.baseSearchUrl,self.searchTextField.text];
    }
    
    self.selectIndex = -1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchButtonClickWithSearchUrl:)]) {
        [self.delegate searchButtonClickWithSearchUrl:searchUrl];
    }
    
}

- (IBAction)tabButtonClick:(UIButton *)sender {
    
    [sender setSelected:!sender.selected];
    for (UIButton *btn in self.bottomButtonsView.subviews) {
        if (btn != sender) {
            [btn setSelected:NO];
        }
    }
    if (sender.selected) {
        self.selectIndex = sender.tag - 1;
    }
    else{
        self.selectIndex = -1;
    }
    
    
    [self searchButtonClick:nil];
}

- (void)setTabTitles:(NSArray *)tabTitles
{
    _tabTitles = tabTitles;
    for (int i = 0; i < tabTitles.count; i++) {
        LZYSearchTabModel *model = tabTitles[i];
        //取出标签按钮
        UIButton *btn = [self.bottomButtonsView viewWithTag:(i + 1)];
        if (btn) {
            [btn setTitle:model.title forState:UIControlStateNormal];
        }
    }
}

- (NSString *)baseSearchUrl
{
    if (!_baseSearchUrl) {
        _baseSearchUrl = @"https://www.baidu.com/s?cl=3&wd=";
    }
    
    return _baseSearchUrl;

}

@end
