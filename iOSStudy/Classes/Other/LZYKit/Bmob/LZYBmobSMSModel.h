//
//  LZYBmobSMSModel.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, smsType) {

    //登录
    kSMSLogin,
    //注册
    kSMSRegister,
    //找回密码
    kSMSforgetPassword

};

@interface LZYBmobSMSModel : NSObject

@property (nonatomic, assign) smsType type;

@property (nonatomic, copy) NSString *smsTypeName;

@end
