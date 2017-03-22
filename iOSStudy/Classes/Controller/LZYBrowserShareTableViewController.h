//
//  LZYShareTableViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/2/25.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZYWebPageModel;
@interface LZYBrowserShareTableViewController : UITableViewController

@property (nonatomic, strong) LZYWebPageModel *webPageModel;

@property (weak, nonatomic) IBOutlet UITextField *contentTitleTextField;


@property (weak, nonatomic) IBOutlet UITextField *tagTextField;


@property (weak, nonatomic) IBOutlet UILabel *urlLabel;


@property (weak, nonatomic) IBOutlet UITextView *urlDescribeTextView;

@end
