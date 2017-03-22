//
//  LZYEditHelpViewController.h
//  iOSStudy
//
//  Created by 李志宇 on 17/3/2.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZYCommentModel;
@class LZYCommentBridgeModel;
@interface LZYEditHelpViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *contentCell;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UIView *imagesView;

@property (weak, nonatomic) IBOutlet UITableViewCell *editLinkCell;

//@property (nonatomic, strong) LZYCommentModel *commentModel;

//传入评论类型等
@property (nonatomic, strong) LZYCommentBridgeModel *commentBridge;

@end
