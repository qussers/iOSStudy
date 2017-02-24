//
//  LZYPersonViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/18.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYPersonViewController.h"
#import "LZYGlobalDefine.h"
#import "LZYPersonBackgroundView.h"
#import "UIView+Xib.h"
#import "LZYPDFReaderViewController.h"
#import "AddFileViewController.h"
#import "LZYLoginViewController.h"
#import "LZYUserModel.h"
#import "UIImageView+LZYWebCache.h"
#import "LZYSettingTableViewController.h"
#define LZYPersonViewHeadHeight 150 * LZYSCREEN_WIDTH / 375.0

@interface LZYPersonViewController ()<LZYPersonBackgroundViewDelegate>

@property (nonatomic, strong) LZYPersonBackgroundView *headBackView;


@end

@implementation LZYPersonViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeNavTitleAttribute];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (!_headBackView) {
        [self makeBackgroundAttribute];
    }
    
    //用户头像等信息
    [self makeUserInfoAttribute];
}

//针对首页视图显示和隐藏tabbar设置
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    [self makeNavAlphaChange:0];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self makeNavAlphaChange:1];
    
}


- (void)makeBackgroundAttribute
{
    _headBackView = (LZYPersonBackgroundView *)[UIView loadViewWithXibName:@"LZYPersonBackgroundView"];
    _headBackView.frame = CGRectMake(0, 0, LZYSCREEN_WIDTH, LZYPersonViewHeadHeight);
    _headBackView.delegate = self;
    [self.view addSubview:_headBackView];
    [self.tableView setContentInset:UIEdgeInsetsMake(LZYPersonViewHeadHeight + 64, 0, 0, 0)];
}

- (void)makeNavTitleAttribute
{
    if (self.navigationItem.title) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.navigationItem.title;
        titleLabel.textColor = [UIColor whiteColor];
        [self.navigationItem setTitleView:titleLabel];
    }
}

- (void)makeNavAlphaChange:(CGFloat)alpha
{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
    self.navigationItem.titleView.alpha = alpha;
}

- (void)makeHeadBackViewFrameChange:(CGFloat)offsetY
{
    if (offsetY <= 0) {
        self.headBackView.frame = CGRectMake(0, -LZYPersonViewHeadHeight + offsetY , LZYSCREEN_WIDTH, LZYPersonViewHeadHeight - offsetY );
    }
    else{
        self.headBackView.frame = CGRectMake(0, -LZYPersonViewHeadHeight, LZYSCREEN_WIDTH, LZYPersonViewHeadHeight);
    }
}

- (void)makeUserInfoAttribute
{
    LZYUserModel *user = (LZYUserModel *) [LZYUserModel getCurrentUser];
    if (user) {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        [self.headBackView.iconImageView lzy_setImageWithURL:user.userIcon ?:LZYDEFAULTICONURL];
        [self.headBackView.loginLabel setHidden:YES];
        [self.headBackView.userNameLabel setHidden:NO];
        self.headBackView.userNameLabel.text = user.username;
    }else{
        [self.headBackView.iconImageView lzy_setImageWithURL:LZYDEFAULTICONURL];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.headBackView.loginLabel setHidden:NO];
        [self.headBackView.userNameLabel setHidden:YES];
    }

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + LZYPersonViewHeadHeight;
    [self makeNavAlphaChange:(offsetY + 64) / 64.0];
    [self makeHeadBackViewFrameChange:offsetY];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *reuseCellKey;
    
    switch (indexPath.row) {

        case 1:
            reuseCellKey = @"personFunctionCell";
            break;
        case 3:
            reuseCellKey = @"personMoneyCell";
            break;
        default:
            reuseCellKey = @"personGapCell";
            break;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:reuseCellKey forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
            return LZYSCREEN_WIDTH / 2.0;
            break;
        case 3:
            return 44;
            break;
        default:
            return 10;
            break;
    }
    
    return 0;
}


- (IBAction)functionViewTap:(id)sender {
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    NSInteger tag = [tap.view tag];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (tag) {
        //PDF阅读界面
        case 1:
        {
            LZYPDFReaderViewController *v = [storyboard instantiateViewControllerWithIdentifier:@"PDFReaderViewController"];
            [self.navigationController pushViewController:v animated:YES];
        }
            break;
        case 2:
        {
            //WIFIUpload
            AddFileViewController *v = [[AddFileViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
            break;
            
        default:
            break;
    }
}

//设置
- (IBAction)userSettingClick:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYSettingTableViewController *v = [storyboard instantiateViewControllerWithIdentifier:@"settingViewController"];
    [self.navigationController pushViewController:v animated:YES];
    
}

#pragma mark - LZYPersonBackgroundViewDelegate

- (void)iconViewClick
{
    if (![LZYUserModel getCurrentUser]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        LZYLoginViewController *v = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
//        [self presentViewController:v animated:YES completion:nil];
        
        UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"UserCenterNavController"];
        
        [self presentViewController:nav animated:YES completion:nil];
    }

}




@end
