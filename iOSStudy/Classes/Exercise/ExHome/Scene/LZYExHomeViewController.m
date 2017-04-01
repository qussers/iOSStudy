//
//  LZYExHomeViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/15.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExHomeViewController.h"
#import "LZYExTitleTableView.h"
#import "LZYGlobalDefine.h"
#import "LZYExDetailViewController.h"


//Test
#import "LZYWebCodeParseModel.h"

@interface LZYExHomeViewController ()

@property (nonatomic, strong) LZYExTitleTableView *titleTableView;


@end

@implementation LZYExHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    [self addUI];
    [self requestData];
    
    LZYWebCodeParseModel *model = [[LZYWebCodeParseModel alloc] init];
    model.url = @"http://www.baidu.com";
    model.name = @"测试数据";
    model.source = @"测试数据";
    model.icon = @"http://www.baidu.com";    
    [model sub_saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//针对首页视图显示和隐藏tabbar设置
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)setUp
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //第一种处理方式！
    __weak typeof(self)weakSelf = self;
    RACCommand *selectCellCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(LZYExSubTitleModel *subModel) {
        //处理跳转逻辑
        LZYExDetailViewController *detailVC = [[LZYExDetailViewController alloc] init];
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
        return [RACSignal empty];
    }];
    
    [self.titleTableView setDidSelectedRowCommand:selectCellCommand];
}


//第二种处理方式！
//事件中枢控制
- (void)routeEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:LZYExTitleCellDidSelectedEvent]) {
        
        LZYExCellSubTitleViewModel *viewModel = [userInfo objectForKey:@"value"];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LZYExDetailViewController *detailVC = [storyBoard instantiateViewControllerWithIdentifier:@"LZYExDetailViewController"];
        detailVC.objectId = viewModel.model.objectId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)addUI
{
    self.titleTableView.tableView.frame = CGRectMake(0, 64, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64);
    [self.view addSubview:self.titleTableView.tableView];
}

- (void)requestData
{
    [[self.titleTableView.fetchDataCommand execute:nil] subscribeError:^(NSError * _Nullable error) {
        
        NSLog(@"网络请求错误!----->vc入口!");
        
    } completed:^{
       
        NSLog(@"网络请求成功--->vc入口");
    }];
}


- (IBAction)rightItemClick:(UIBarButtonItem *)sender {
    
    NSArray *viewControlelrs = self.tabBarController.viewControllers;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [storyBoard instantiateViewControllerWithIdentifier:@"IZJHomeViewControllerNav"];
    NSArray *newViewControllers = @[nav,viewControlelrs[1],viewControlelrs[2],viewControlelrs[3]];
    
    [self.tabBarController setViewControllers:newViewControllers];
}




#pragma mark - lazy

- (LZYExTitleTableView *)titleTableView
{
    if (!_titleTableView) {
        _titleTableView = [LZYExTitleTableView instanceWithViewModel:[LZYExTitleViewModel viewModel]];
    }
    return _titleTableView;
}



@end
