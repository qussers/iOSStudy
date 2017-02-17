//
//  LZYHomeSubViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/17.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYHomeSubViewController.h"
#import "LZYSecondSubjectTableViewController.h"
#import "LZYGlobalDefine.h"
@interface LZYHomeSubViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) LZYSecondSubjectTableViewController *knowledgeViewController;
@property (nonatomic, strong) LZYSecondSubjectTableViewController *questionViewController;

@end

@implementation LZYHomeSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeSubViewsAttribute];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeSubViewsAttribute
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(LZYSCREEN_WIDTH * 2, LZYSCREEN_HEIGHT - 64);
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.pagingEnabled = YES;
    [self addChildViewController:self.knowledgeViewController];
    [self addChildViewController:self.questionViewController];
    UIView *kView = self.knowledgeViewController.view;
    UIView *qView = self.questionViewController.view;
    kView.frame = CGRectMake(0, 0, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64);
    qView.frame = CGRectMake(LZYSCREEN_WIDTH, 0, LZYSCREEN_WIDTH, LZYSCREEN_HEIGHT - 64);
    [self.contentScrollView addSubview:kView];
    [self.contentScrollView addSubview:qView];
}


- (IBAction)segAction:(id)sender {
    
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            [self.contentScrollView setContentOffset:CGPointMake(0, 0)];
            break;
        case 1:
            [self.contentScrollView setContentOffset:CGPointMake(LZYSCREEN_WIDTH, 0)];
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollerDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= LZYSCREEN_WIDTH) {
        self.segment.selectedSegmentIndex = 1;
    }
    else{
        self.segment.selectedSegmentIndex = 0;
    }
    
}

#pragma mark - lazy

- (LZYSecondSubjectTableViewController *)knowledgeViewController
{
    if (!_knowledgeViewController) {
        UIStoryboard *stotyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _knowledgeViewController = [stotyboard instantiateViewControllerWithIdentifier:@"secondSubject"];
        _knowledgeViewController.subjectTag = self.subjectTag;
        _knowledgeViewController.contentType = kKnowledge;
    }
    return _knowledgeViewController;
}


- (LZYSecondSubjectTableViewController *)questionViewController
{
    if (!_questionViewController) {
        UIStoryboard *stotyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _questionViewController = [stotyboard instantiateViewControllerWithIdentifier:@"secondSubject"];
        _questionViewController.subjectTag = self.subjectTag;
        _questionViewController.contentType = kQuestion;
    }
    return _questionViewController;
}

@end
