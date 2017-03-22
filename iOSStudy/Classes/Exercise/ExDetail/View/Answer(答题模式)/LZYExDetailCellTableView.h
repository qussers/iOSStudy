//
//  LZYExDetailCellTableView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZYExDetailCellViewModel.h"
@interface LZYExDetailCellTableView : NSObject

@property (nonatomic, strong) LZYExDetailCellViewModel *viewModel;

//cell点击回调
@property (nonatomic, strong) RACSubject *cellClickSubject;

+ (instancetype)instanceWitViewModel:(LZYExDetailCellViewModel *)viewModel;

- (UITableView *)tableView;



@end
