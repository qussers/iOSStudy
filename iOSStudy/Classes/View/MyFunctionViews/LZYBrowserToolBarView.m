//
//  LZYBrowserToolBarView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBrowserToolBarView.h"

@implementation LZYBrowserToolBarView


- (IBAction)leftBackClick:(UIButton *)sender {
    
    [self toolBarClickWithIndex:0];
}

- (IBAction)rightGoClick:(UIButton *)sender {
    
    [self toolBarClickWithIndex:1];
}


- (IBAction)saveButtonClick:(UIButton *)sender {
    
    [self toolBarClickWithIndex:3];
    
}
- (IBAction)shareButtonClick:(UIButton *)sender {
    
    [self toolBarClickWithIndex:2];
}

- (IBAction)copyButtonClick:(UIButton *)sender {
    
    [self toolBarClickWithIndex:4];
}

- (void)toolBarClickWithIndex:(NSInteger)index
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(browserToolBarClickWithIndex:)]) {
        
        [self.delegate browserToolBarClickWithIndex:index];
    }


}

@end
