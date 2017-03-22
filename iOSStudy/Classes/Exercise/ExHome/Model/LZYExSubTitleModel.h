//
//  LZYExSubTitleModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/14.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "LZYExTitleModel.h"
@interface LZYExSubTitleModel : BmobObject

@property (nonatomic, copy) NSString *title;

//pointer-->指向所在的标题对象（BMOB数据结构不支持多表联查，所以选择反过来用‘子’->pointer->'父'嵌套）
@property (nonatomic, strong) LZYExTitleModel *titleModel;

@end
