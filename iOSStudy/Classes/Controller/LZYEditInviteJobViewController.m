//
//  LZYEditInviteJobViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/2.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYEditInviteJobViewController.h"
#import "LZYGlobalDefine.h"
#import "LZYNetwork.h"
#import "LZYInviteJobModel.h"

#define LZYEditSalaryData  @[@"5-10K",@"10-15K",@"15-25K",@"25-50K",@"50K以上"]

#define LZYEditExprienceData  @[@"低于1年",@"1-3年",@"3-5年",@"5-10年",@"10年以上"]

#define LZYEditAcademicData  @[@"大专",@"本科",@"硕士",@"博士",@"博士以上"]



@interface LZYEditInviteJobViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray *tagsDataSource;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *pickerDataSource;

@property (nonatomic, assign) NSInteger currentSelectTag;

@end

@implementation LZYEditInviteJobViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setup
{
    

   
}


- (void)showPickViewWithDataSource:(NSArray *)dataSource
{

    if (!self.pickerView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.pickerView];
    }
    
    self.pickerDataSource.array = dataSource;
    [self.pickerView reloadAllComponents];
    CGRect nRect = self.pickerView.frame;
    nRect.origin.y = self.tableView.frame.size.height - nRect.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = nRect;
    }];
}


- (void)hiddenPickerView
{
    
    CGRect react = CGRectMake(0, self.tableView.frame.size.height, self.tableView.frame.size.width, 200);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = react;
    }completion:^(BOOL finished) {
        [self.pickerView removeFromSuperview];
    }];
    
}

//tag1
- (IBAction)salaryBtnClick:(id)sender {
    
    [self.view endEditing:YES];
    [self showPickViewWithDataSource:LZYEditSalaryData];
    self.currentSelectTag = 1;
}


//tag2
- (IBAction)academicBtnClick:(id)sender {
    
    [self.view endEditing:YES];
    [self showPickViewWithDataSource:LZYEditAcademicData];
    self.currentSelectTag = 2;
    
}

//tag3
- (IBAction)experienceBtnClick:(id)sender {
    
    [self.view endEditing:YES];
    [self showPickViewWithDataSource:LZYEditExprienceData];
    self.currentSelectTag = 3;
    
}


- (IBAction)tagBtnClick:(UIButton *)sender {
    
    UIButton *tagBtn = sender;
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

- (IBAction)confirmBtnClick:(id)sender {
    
    LZYInviteJobModel *inviteModel = [[LZYInviteJobModel alloc] init];
    inviteModel.companyName = self.companyNameTextField.text;
    inviteModel.jobTitle = self.jobNameTextField.text;
    inviteModel.salary = self.salaryButton.titleLabel.text;
    inviteModel.academic = self.academicButton.titleLabel.text;
    inviteModel.experience = self.experienceButton.titleLabel.text;
    inviteModel.address = self.addressTextField.text;
    inviteModel.email = self.emailTextField.text;
    inviteModel.tags = self.tagsDataSource;
    inviteModel.duty = self.dutyTextView.text;
    inviteModel.demand = self.demandTextView.text;
    if ([BmobUser currentUser]) {
        BmobUser *user = [BmobUser currentUser];
        inviteModel.userId = user.objectId;
        inviteModel.userName = user.username;
        inviteModel.userIcon = [user objectForKey:@"userIcon"];
        inviteModel.user = user;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [inviteModel sub_saveInBackground];
    }];
    
}
- (IBAction)cancelBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hiddenPickerView];
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerDataSource.count;
}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return self.pickerDataSource[row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
 
    switch (self.currentSelectTag) {
        case 1:
            [self.salaryButton setTitle:self.pickerDataSource[row] forState:UIControlStateNormal];
            break;
        case 2:
            [self.academicButton setTitle:self.pickerDataSource[row] forState:UIControlStateNormal];
            break;
        case 3:
            [self.experienceButton setTitle:self.pickerDataSource[row] forState:UIControlStateNormal];
            break;
            
        default:
            break;
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

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height, self.tableView.frame.size.width, 200)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _pickerView;
}

- (NSMutableArray *)pickerDataSource
{
    if (!_pickerDataSource ) {
        _pickerDataSource = @[].mutableCopy;
    }
    return _pickerDataSource;
}
@end
