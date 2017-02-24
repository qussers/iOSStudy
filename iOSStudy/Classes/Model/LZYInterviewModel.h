//
//  LZYInterviewModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/21.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface LZYInterviewModel : BmobObject


@property (nonatomic, copy) NSString *jobTitle;


@property (nonatomic, copy) NSString *companyName;


@property (nonatomic, strong) NSArray *tagArr;


@property (nonatomic, assign) NSInteger likes;


@property (nonatomic, copy) NSString *interviewContent;


@property (nonatomic, copy) NSString *interviewUserName;


@property (nonatomic, assign) NSInteger commentCount;


@property (nonatomic, copy) NSString *interviewUserId;



@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat totalCellHeight;

@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, assign) BOOL isWordBreak;

@end
