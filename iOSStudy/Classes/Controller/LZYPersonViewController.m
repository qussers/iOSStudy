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

#define LZYPersonViewHeadHeight 150 * LZYSCREEN_WIDTH / 375.0

@interface LZYPersonViewController ()

@property (nonatomic, strong) LZYPersonBackgroundView *headBackView;


@end

@implementation LZYPersonViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeBackgroundAttribute];
    [self makeNavTitleAttribute];
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



@end
