//
//  LZYHomeViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/16.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYHomeViewController.h"
#import "LZYGlobalDefine.h"
#import "UIView+Xib.h"
#import "LZYNetwork.h"
#import "LZYSubjectTitleModel.h"
#import "LZYHomeSegView.h"
#import "LZYSecondSubjectTableViewController.h"
#import "LZYHomeSubViewController.h"
#import "UIColor+LZYAdd.h"
#import "NSString+LZYAdd.h"


#import "LZYExpertModel.h"
@interface LZYHomeViewController ()<iCarouselDataSource, iCarouselDelegate>


@property (nonatomic ,strong) NSMutableArray *dataSource;




@end

@implementation LZYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCarouselView];
    [self requestData];
    

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCarouselView
{
    self.carouselView.type = iCarouselTypeCylinder;

}

- (void)requestData
{
    [self.view beginLoading];
    [LZYNetwork requestSubjectTitlesWithTableName:nil success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:result];
        [self.carouselView reloadData];
        [self.view endLoading];
    } failure:^(id result) {
        [self.view loadError];
    }];
}

- (IBAction)rightItemClick:(UIBarButtonItem *)sender {
    
    NSArray *viewControlelrs = self.tabBarController.viewControllers;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [storyBoard instantiateViewControllerWithIdentifier:@"LZYHomeExViewNavController"];
    NSArray *newViewControllers = @[nav,viewControlelrs[1],viewControlelrs[2],viewControlelrs[3]];
    
    [self.tabBarController setViewControllers:newViewControllers];
    
}



#pragma marj - iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.dataSource.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        view = [LZYHomeSegView loadViewWithXibName:@"LZYHomeSegView"];
        view.bounds = CGRectMake(0, 0, LZYSCREEN_WIDTH - 150 * (LZYSCREEN_WIDTH / 375.0), self.carouselView.frame.size.height);
    }
    if ([view isKindOfClass:[LZYHomeSegView class]]) {
        LZYHomeSegView *myView = (LZYHomeSegView *)view;
        LZYSubjectTitleModel *model = self.dataSource[index];
        myView.backgroundColor = [UIColor colorWithHexString:model.color];
        [myView.titleBtn setTitle:model.subTitle forState:UIControlStateNormal];
    }
    return view;
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
    {
        switch (option)
        {
            case iCarouselOptionWrap:
            {
                return 1;
            }
            case iCarouselOptionFadeMax:
            {
                if (carousel.type == iCarouselTypeCustom)
                {
                    return 0.0f;
                }
                return value;
            }
            case iCarouselOptionSpacing:
                {
                    return value * 1.6;
                }
            default:
            {
                return value;
            }
        }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    UIStoryboard *stotyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LZYHomeSubViewController *vc = [stotyboard instantiateViewControllerWithIdentifier:@"homeSubViewController"];
    LZYSubjectTitleModel *model = self.dataSource[index];
    vc.subjectTag = model.subTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    
    return _dataSource;
}



@end
