//
//  LZYNearChatViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/1.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYNearChatViewController.h"
#import <BmobSDK/Bmob.h>
@interface LZYNearChatViewController ()<RCIMUserInfoDataSource>


@end

@implementation LZYNearChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    self.conversationListTableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    UITabBarController *rootVc = (id)[[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVc.tabBar setHidden:YES];
    [self.navigationController pushViewController:conversationVC animated:YES];
}



#pragma mark - 登录相关

/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    BmobQuery *query = [BmobUser query];
    [query whereKey:@"username" equalTo:userId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            BmobObject *obj = array[0];
            RCUserInfo *user = [[RCUserInfo alloc] init];
            user.userId = [obj objectForKey:@"username"];
            user.name = [obj objectForKey:@"littleName"];
            user.portraitUri = [obj objectForKey:@"userPhoto"];
            return completion(user);
        }
    }];
}


@end
