//
//  LZYCommentBridgeModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/7.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CommentType) {

    kHelpComment = 1,
    kShareComment,
    kInterviewComment,
    kInviteComment,

};

@interface LZYCommentBridgeModel : NSObject

//所属内容id
@property (nonatomic, copy) NSString *contentObjectId;

//评论类型
@property (nonatomic, assign) CommentType commentType;

@property (nonatomic, copy) NSString *pointerObjectName;

@end
