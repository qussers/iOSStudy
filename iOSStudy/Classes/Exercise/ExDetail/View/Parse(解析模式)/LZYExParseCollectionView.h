//
//  LZYExParseCollectionView.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExDetailCollectionView.h"
#import "LZYExParseViewModel.h"
@interface LZYExParseCollectionView : LZYExDetailCollectionView

- (RACCommand *)parseDataCommand;

@end
