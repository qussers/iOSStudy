//
//  LZYExSubmitView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import "LZYExSubmitViewModel.h"


typedef NS_ENUM(NSInteger, ExResultType) {
    
    kOverView,
    kResult
};


@interface LZYExSubmitView : NSObject

+ (instancetype)instanceWithViewModel:(LZYExSubmitViewModel *)viewModel;

- (UICollectionView *)collectionView;


- (RACCommand *)fetchDataCommand;

- (RACCommand *)submitDataCommand;

//点击了某个cell
@property (nonatomic, strong) RACSubject *cellDidClickSubject;


//点击了提交
@property (nonatomic, strong) RACSubject *completedClickSubject;



@property (nonatomic, assign) ExResultType type;



@end
