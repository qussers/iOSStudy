//
//  LZYEditInterviewViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYEditInterviewViewController.h"
#import <BmobSDK/Bmob.h>
#import "LZYInterviewModel.h"
@interface LZYEditInterviewViewController ()

@property (nonatomic, strong) NSMutableArray *tagsDataSource;

@end

@implementation LZYEditInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)upload:(id)sender {
    
    //上传
    LZYInterviewModel *model = [[LZYInterviewModel alloc] init];
    model.companyName = self.companyNameText.text;
    model.jobTitle = self.jobTitleText.text;
    model.interviewContent = self.interviewContentTextView.text;
    model.tagArr = self.tagsDataSource;
    [model sub_saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
       
        if (isSuccessful) {
            NSLog(@"上传成功!");
        }
        else{
            NSLog(@"%@",error);
        }
        
    }];
    
    
}


- (IBAction)tabButtonClick:(id)sender {
    
    UIButton *tagBtn = (UIButton *)sender;
    [tagBtn setSelected:!tagBtn.selected];
    NSString *tagTitle = tagBtn.titleLabel.text;
    
    if (tagBtn.selected) {
        if (![self.tagsDataSource containsObject:tagTitle]) {
            [self.tagsDataSource addObject:tagTitle];
        }
    }else{
    
        if ([self.tagsDataSource containsObject:tagTitle]) {
            [self.tagsDataSource removeObject:tagTitle];
        }
    }
    
}


#pragma mark - lazy

- (NSMutableArray *)tagsDataSource
{
    if (!_tagsDataSource) {
        _tagsDataSource = @[].mutableCopy;
    }
    return _tagsDataSource;
}

@end
