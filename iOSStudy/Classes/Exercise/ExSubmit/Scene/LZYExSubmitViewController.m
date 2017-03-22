//
//  LZYExSubmitViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYExSubmitViewController.h"
#import "LZYExSubmitView.h"
#import "LZYGlobalDefine.h"
#import "LZYExSubmitBottom.h"
#import "UIView+Xib.h"
@interface LZYExSubmitViewController ()

@property (nonatomic, strong) LZYExSubmitView *submit;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) LZYExSubmitBottom *bottomView;

@end

@implementation LZYExSubmitViewController

- (instancetype)initWithData:(NSArray *)data
{
    if (self = [super init]) {
     
        _data = data;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    [self addUI];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp
{
    LZYExSubmitViewModel *viewModel = [LZYExSubmitViewModel viewModelWithDataSource:self.data];
    _submit = [LZYExSubmitView instanceWithViewModel:viewModel];
    RACSubject *cellDidClick = [RACSubject subject];
    RACSubject *completedClick = [RACSubject subject];
    _submit.cellDidClickSubject = cellDidClick;
    _submit.completedClickSubject = completedClick;
    
    @weakify(self);
    [cellDidClick subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //返回
        [self.overViewClickSubject sendNext:x];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [completedClick subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.parseClickSubject sendNext:x];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    [[self.bottomView.titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        UIButton *button = (UIButton *)x;
        if (!button.isSelected) {
            [[self.submit.submitDataCommand execute:nil] subscribeCompleted:^() {
                [button setSelected:YES];
            }];
        }
        else{
            //查看解析
            [self.parseClickSubject sendNext:@(0)];
            [self.navigationController popViewControllerAnimated:YES];
        }
      
    }];
    
    
    
    
}

- (void)addUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.submit.collectionView.frame = CGRectMake(0,0, LZYSCREEN_WIDTH, self.view.frame.size.height - 49);
    self.bottomView.frame = CGRectMake(0, LZYSCREEN_HEIGHT - 49, LZYSCREEN_WIDTH, 49);
    [self.view addSubview:self.submit.collectionView];
    [self.view addSubview:self.bottomView];
}

- (void)requestData
{
    [[self.submit.fetchDataCommand execute:nil] subscribeCompleted:^{
        //数据请求完成！
        NSLog(@"数据转化完成喽！！！😂");
    }];;
}


#pragma mark - lazy

- (LZYExSubmitBottom *)bottomView
{
    if (!_bottomView) {
        _bottomView = (LZYExSubmitBottom *)[UIView loadViewWithXibName:NSStringFromClass([LZYExSubmitBottom class])];
    }
    return _bottomView;
}


@end
