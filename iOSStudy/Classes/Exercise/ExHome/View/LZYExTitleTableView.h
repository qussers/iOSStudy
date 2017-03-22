//
//  LZYExTitleTableView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZYExTitleViewModel.h"
@interface LZYExTitleTableView : NSObject

+ (instancetype)instanceWithViewModel:(LZYExTitleViewModel *)viewModel;

- (UITableView *)tableView;

- (RACCommand *)fetchDataCommand;

- (void)setDidSelectedRowCommand:(RACCommand *)didSelectedRowCommand;

@end
