//
//  LZYBrowserViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYBrowserViewController.h"
#import "LZYGlobalDefine.h"
#import "UIView+Xib.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "LZYMoreButtonTableViewCell.h"
#import "LZYBrowserWebViewController.h"
#import "LZYLeftTitleSectionHeaderView.h"
#import "LZYNewsBigImageTableViewCell.h"
#import "LZYNewsLeftImageTableViewCell.h"
#import "LZYNewsThreeImageTableViewCell.h"
#import "LZYLeftTitleSectionHeaderCell.h"
#import "LZYBrowserSearchWebViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "LZYSearchTabModel.h"
#import "LZYNetwork.h"
#import <YYKit.h>
#import "LZYExpertModel.h"
#import "UIButton+LZYWebCache.h"
#import "LZYWebPushTool.h"
@interface LZYBrowserViewController ()<UITableViewDelegate,UITableViewDataSource,LZYBrowserHeaderViewDelegate,LZYMoreButtonTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZYBrowserHeaderView *searchHeaderView;

@property (nonatomic, strong) NSMutableArray *expertData;

@end

@implementation LZYBrowserViewController

CGFloat headerViewDefaultHeight = 80;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    [self setAttribute];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.searchHeaderView.searchTextField resignFirstResponder];
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


- (void)setup
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchHeaderView];
}

- (void)setAttribute
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView setContentInset:UIEdgeInsetsMake(headerViewDefaultHeight, 0, 0, 0)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LZYLeftTitleSectionHeaderCell" bundle:nil] forCellReuseIdentifier:@"LZYLeftTitleSectionHeaderCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LZYMoreButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"LZYMoreButtonTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LZYNewsBigImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"LZYNewsBigImageTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LZYNewsLeftImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"LZYNewsLeftImageTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LZYNewsThreeImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"LZYNewsThreeImageTableViewCell"];
}


- (void)requestData
{
    [LZYNetwork requestCloudAPI:LZY_CLOUDAPI_WEBHOME paramerters:nil block:^(id result, NSError *error) {
        if (error) {
            return;
        }
        if ([result isKindOfClass:[NSDictionary class]]) {
            //字典转模型
            NSArray *experts = [NSArray modelArrayWithClass:[LZYExpertModel class] json:result[@"LZYExpertModel"]];
            self.expertData.array = experts;
            [self.tableView reloadData];
        }
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1 + 1;
            break;
        case 1:
            return 6 + 1;
            break;
        case 2:
            return 1 + 1;
            break;
        case 3:
            return 1 + 1;
            break;
        case 4:
            return 10;
            break;
            
        default:
            break;
    }
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //标题
    if (indexPath.row == 0) {
        LZYLeftTitleSectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYLeftTitleSectionHeaderCell" forIndexPath:indexPath];
        switch (indexPath.section) {
            case 0:
                cell.titleLabel.text = @"技术大咖";
                break;
            case 1:
                cell.titleLabel.text = @"今日练习";
                break;
            case 2:
                cell.titleLabel.text = @"源码解析";
                break;
            case 3:
                cell.titleLabel.text = @"好书推荐";
                break;
            case 4:
                cell.titleLabel.text = @"行业热门";
                break;
            default:
                break;
        }

        return cell;
    }
    
    //不同类别的cell
    switch (indexPath.section) {
            //技术大咖
        case 0:{
            LZYMoreButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYMoreButtonTableViewCell" forIndexPath:indexPath];
            cell.delegate = self;
            [self configeExpertCell:cell];
            return cell;
        
        }
            break;
            //今日练习
        case 1:{
            LZYNewsLeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsLeftImageTableViewCell" forIndexPath:indexPath];
            
            return cell;
        }
            break;
            //源码解析
        case 2:{
            
            if (indexPath.row % 3 == 0) {
                LZYNewsBigImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsBigImageTableViewCell" forIndexPath:indexPath];
                
                return cell;
            }
            if (indexPath.row % 2 == 0) {
                LZYNewsLeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsLeftImageTableViewCell" forIndexPath:indexPath];
                
                return cell;
            }
            
            if (indexPath.row % 1 == 0) {
                LZYNewsThreeImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsThreeImageTableViewCell" forIndexPath:indexPath];
                return cell;
            }
            
        }
            
            break;
            //好书推荐
        case 3:{
            
            LZYMoreButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYMoreButtonTableViewCell" forIndexPath:indexPath];
            return cell;

        }
            
            break;
            
            //热门动态
        case 4:{
            
            if (indexPath.row % 5 == 0) {
                LZYNewsBigImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsBigImageTableViewCell" forIndexPath:indexPath];
                
                return cell;
            }
            if (indexPath.row % 3 == 0) {
                LZYNewsLeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsLeftImageTableViewCell" forIndexPath:indexPath];
                
                return cell;
            }
            
            if (indexPath.row % 2 == 0) {
                LZYNewsThreeImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsThreeImageTableViewCell" forIndexPath:indexPath];
                return cell;
            }
            
            LZYNewsLeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsLeftImageTableViewCell" forIndexPath:indexPath];
            
            return cell;
            
        }
            break;
            
        default:
        {
            LZYNewsLeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZYNewsLeftImageTableViewCell" forIndexPath:indexPath];
            
            return cell;
        }
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    switch (indexPath.section) {
            //技术大咖
        case 0:{
            return [LZYMoreButtonTableViewCell cellHeight];
        }
            break;
            //今日练习
        case 1:{
            return  [LZYNewsLeftImageTableViewCell cellHeight];
        }
            break;
            //源码解析
        case 2:{
            
            if (indexPath.row % 3 == 0) {
              return  [LZYNewsBigImageTableViewCell cellHeight];
            }
            if (indexPath.row % 2 == 0) {
                return [LZYNewsLeftImageTableViewCell cellHeight];
            }
            
            if (indexPath.row % 1 == 0) {
               return  [tableView fd_heightForCellWithIdentifier:NSStringFromClass([LZYNewsThreeImageTableViewCell class]) configuration:nil];
            }
            
        }
            break;
            //好书推荐
        case 3:{
          return [LZYMoreButtonTableViewCell cellHeight];
        }
            break;
            //热门动态
        case 4:{
            if (indexPath.row % 5 == 0) {
               return [LZYNewsBigImageTableViewCell cellHeight];
            }
            if (indexPath.row % 3 == 0) {
                return [LZYNewsLeftImageTableViewCell cellHeight];
            }
            
            if (indexPath.row % 2 == 0) {
                return  [LZYNewsThreeImageTableViewCell cellHeight];
            }
             return [LZYNewsLeftImageTableViewCell cellHeight];
        }
            break;
            
        default:
        {
            return  [LZYNewsLeftImageTableViewCell cellHeight];
        }
            break;
    }
    
    return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    LZYBrowserSearchWebViewController *v = [[LZYBrowserSearchWebViewController alloc] init];
    v.webUrl = @"https://m.baidu.com";
    [self.navigationController pushViewController:v animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchHeaderView.searchTextField resignFirstResponder];
    CGFloat offsetY = scrollView.contentOffset.y + headerViewDefaultHeight;
    CGRect newHeadViewReact = self.searchHeaderView.frame;
    CGRect newBottomButtonsViewReact = self.searchHeaderView.bottomButtonsView.frame;
    //标签跟着滑动
    if ( headerViewDefaultHeight - 44 >= offsetY && offsetY > 0) {
        newHeadViewReact.size.height = headerViewDefaultHeight - offsetY;
        newHeadViewReact.origin.y = 20;
        newBottomButtonsViewReact.origin.y = - offsetY;
        self.searchHeaderView.frame = newHeadViewReact;
        self.searchHeaderView.bottomButtonsView.frame = newBottomButtonsViewReact;
    }else if (offsetY <= 0) {
        newHeadViewReact.size.height = headerViewDefaultHeight;
        newHeadViewReact.origin.y = -offsetY + 20;
        newBottomButtonsViewReact.origin.y = 44;
        self.searchHeaderView.frame = newHeadViewReact;
        self.searchHeaderView.bottomButtonsView.frame = newBottomButtonsViewReact;
    }else if(headerViewDefaultHeight - 44 < offsetY){
        newHeadViewReact.size.height = 44;
        newBottomButtonsViewReact.origin.y = 0;
        self.searchHeaderView.frame = newHeadViewReact;
        self.searchHeaderView.bottomButtonsView.frame = newBottomButtonsViewReact;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetY = scrollView.contentOffset.y + headerViewDefaultHeight;
    
    if ( headerViewDefaultHeight - 44 >= offsetY && offsetY > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - LZYSearchButtonDelegate

- (void)searchButtonClickWithSearchUrl:(NSString *)url
{

    LZYBrowserWebViewController *v = [[LZYBrowserWebViewController alloc] init];
    NSString *utf_8 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    v.webUrl = utf_8;
    [self.navigationController pushViewController:v animated:YES];
}

#pragma mark - LZYMoreButtonTableViewCellDelegate
- (void)cell:(LZYMoreButtonTableViewCell *)cell didClickButtonIndex:(NSInteger)index
{
    LZYExpertModel *model = self.expertData[index];
    [LZYWebPushTool userClickWebUrlBtnFormViewController:self url:model.url];

}

#pragma mark - configeCell

- (void)configeExpertCell:(LZYMoreButtonTableViewCell *)cell
{

    if (!_expertData) {
        return;
    }
    //遍历
    for ( NSUInteger i = 0, max = self.expertData.count ; i < max ; i++) {
        UIView *V = [cell.buttonsView viewWithTag:i + 1];
        LZYExpertModel *model = self.expertData[i];
        for (UIView *subV in V.subviews) {
            if ([subV isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)subV;
                [btn lzy_setImageWithURL:model.icon];
            }
            if ([subV isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)subV;
                label.text = model.name;
            }
        }
    }

}


#pragma mark - lazy

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (LZYBrowserHeaderView *)searchHeaderView
{
    if (!_searchHeaderView) {
        _searchHeaderView = (LZYBrowserHeaderView *)[UIView loadViewWithXibName:@"LZYBrowserHeaderView"];
        _searchHeaderView.delegate = self;
        _searchHeaderView.frame = CGRectMake(0, 20, LZYSCREEN_WIDTH , headerViewDefaultHeight);
        NSArray *titles = @[@"简书",@"csdn",@"github",@"cocoa",@"stackO"];
        NSArray *urls = @[@"http://www.jianshu.com/c/3233d1a249ca",
                          @"http://www.jianshu.com/c/3233d1a249ca",
                          @"http://www.jianshu.com/c/3233d1a249ca",
                          @"http://www.jianshu.com/c/3233d1a249ca",
                          @"http://www.jianshu.com/c/3233d1a249ca"];
        NSMutableArray *titlesArr = @[].mutableCopy;
        for (int i = 0; i < 5; i ++) {
            LZYSearchTabModel *model = [[LZYSearchTabModel alloc ]init];
            model.title = titles[i];
            model.domainName = urls[i];
            [titlesArr addObject:model];
        }
        
        _searchHeaderView.tabTitles = titlesArr;
    }
    
    return _searchHeaderView;
}


#pragma mark - lazy

- (NSMutableArray *)expertData
{
    if (!_expertData) {
        _expertData = @[].mutableCopy;
    }
    return _expertData;
}

@end
