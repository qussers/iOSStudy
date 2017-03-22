//
//  LZYEditHelpViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/3/2.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYEditHelpViewController.h"
#import "LGPhoto.h"
#import "LZYGlobalDefine.h"
#import "LZYALAssetModel.h"
#import "LZYNetwork.h"
#import "LZYHelpModel.h"
#import "LZYCommentModel.h"
#import "LZYCommentBridgeModel.h"
@interface LZYEditHelpViewController ()<LGPhotoPickerViewControllerDelegate,LGPhotoPickerBrowserViewControllerDelegate,LGPhotoPickerBrowserViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *browserPhotoArray;


@end


@implementation LZYEditHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshImages];
    [self.contentTextView becomeFirstResponder];

}


- (void)setup{

    if (!self.commentBridge) {
        [self.editLinkCell setHidden:YES];
    }
}

- (IBAction)deleteBtnClick:(UIButton *)sender {

    NSInteger index = sender.tag - 11;
    [self.images removeObjectAtIndex:index];
    [self refreshImages];
}



- (IBAction)cannelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (IBAction)confirmBtnClick:(id)sender {
    
    if (self.images.count == 0) {
        if (self.commentBridge) {
            
            LZYCommentModel *commentModel = [[LZYCommentModel alloc] init];

            commentModel.pointerId = self.commentBridge.contentObjectId;
            commentModel.user = [BmobUser currentUser];
            commentModel.content = self.contentTextView.text;
            [commentModel sub_saveInBackground];
            BmobObject *helpModel = [BmobObject objectWithoutDataWithClassName:self.commentBridge.pointerObjectName objectId:self.commentBridge.contentObjectId];
            [helpModel incrementKey:@"commentCount"];
            [helpModel updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                NSLog(@"%@",error);
            }];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            LZYHelpModel *model = [[LZYHelpModel alloc] init];
            model.content = self.contentTextView.text;
            model.user = [BmobUser currentUser];
            [model sub_saveInBackground];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        return;
    }
    
    NSMutableArray *imageArry = @[].mutableCopy;
    for (LZYALAssetModel *model in self.images) {
        if (model.lgAsset) {
            [imageArry addObject:model.lgAsset.originImage];
        }
        else{
            [imageArry addObject:model.zlAsset.photoImage];
        }
    }

    [LZYNetwork uploadImages:imageArry progressBlock:^(int index, float progress) {
        
    } result:^(NSArray *array, BOOL isSuccessfule, NSError *error) {
        
        if (!isSuccessfule) {
            return ;
        }
        if (self.commentBridge) {
            LZYCommentModel *commentModel = [[LZYCommentModel alloc] init];
            commentModel.pointerId = self.commentBridge.contentObjectId;
            commentModel.user = [BmobUser currentUser];
            commentModel.images = array;
            commentModel.content = self.contentTextView.text;
            [commentModel sub_saveInBackground];
            BmobObject *helpModel = [BmobObject objectWithoutDataWithClassName:self.commentBridge.pointerObjectName objectId:commentModel.pointerId];
            [helpModel incrementKey:@"commentCount"];
            [helpModel updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                NSLog(@"%@",error);
            }];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            
            LZYHelpModel *model = [[LZYHelpModel alloc] init];
            model.content = self.contentTextView.text;
            model.images = array;
            model.user = [BmobUser currentUser];
            [model sub_saveInBackground];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
    
}


- (IBAction)imageClick:(UITapGestureRecognizer *)sender {

    [self.contentTextView resignFirstResponder];
    UIImageView *view = (UIImageView *)sender.view;
    NSInteger tag = view.tag;
    if (tag > self.images.count) {
        //添加图片
        [self confirmAddImage];
    }
    else{
        //浏览图片
        [self browserImagesWithIndex:tag - 1];
    }
}

//刷新图片视图
- (void)refreshImages
{
   
    [self.browserPhotoArray removeAllObjects];
    //确定cell高度
    for (int i = 0; i < 9; i++) {
        UIImageView *imageV = [self.imagesView viewWithTag:(i + 1)];
        UIButton *deleteBtn = [self.imagesView viewWithTag:i + 11];
        if (i < self.images.count) {
            LZYALAssetModel *asset = self.images[i];
            LGPhotoPickerBrowserPhoto *browserPhoto = [[LGPhotoPickerBrowserPhoto alloc] init];
            if (asset.zlAsset) {
              imageV.image = [asset.zlAsset thumbImage];
              browserPhoto.photoImage = [asset.zlAsset photoImage];
            }
            else{
              imageV.image = [asset.lgAsset thumbImage];
               browserPhoto.photoImage = [asset.lgAsset originImage];
            }
            [self.browserPhotoArray addObject:browserPhoto];
            [deleteBtn setHidden:NO];
            [imageV setHidden:NO];
        }
        else if(i == self.images.count){
            imageV.image = [UIImage imageNamed:@"添加"];
            [imageV setHidden:NO];
            [deleteBtn setHidden:YES];
        }
        else{
            [imageV setHidden:YES];
            [deleteBtn setHidden:YES];
        }
    }

    [self.tableView reloadData];
}



- (void)confirmAddImage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"获取途径" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addImageFormPhotoAlbum];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从照相机获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addImageFormCamera];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


//从相册获取图片
- (void)addImageFormPhotoAlbum
{
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:LGShowImageTypeImagePicker];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // 最多能选9张图片
    pickerVc.maxCount = 9;
    pickerVc.delegate = self;
    NSMutableArray *images = @[].mutableCopy;
    for (LZYALAssetModel *model in self.images) {
        if (model.lgAsset) {
            [images addObject:model.lgAsset];
        }
    }
    pickerVc.selectPickers = images;
    [pickerVc showPickerVc:self];

}

//从相机获取
- (void)addImageFormCamera
{
    ZLCameraViewController *cameraVC = [[ZLCameraViewController alloc] init];
    cameraVC.maxCount = 9 - self.images.count;
    cameraVC.cameraType = ZLCameraContinuous;
    cameraVC.callback = ^(NSArray *cameras){
        for (ZLCamera *zlAsset in cameras) {
            LZYALAssetModel *model = [[LZYALAssetModel alloc] init];
            model.zlAsset = zlAsset;
            [self.images addObject:model];
        }
        [self refreshImages];
    };
    [cameraVC showPickerVc:self];
}

//浏览图片
- (void)browserImagesWithIndex:(NSInteger)index
{
    LGPhotoPickerBrowserViewController *BroswerVC = [[LGPhotoPickerBrowserViewController alloc] init];
    BroswerVC.delegate = self;
    BroswerVC.dataSource = self;
    BroswerVC.showType = LGShowImageTypeImageBroswer;
    BroswerVC.editing = YES;
    BroswerVC.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self presentViewController:BroswerVC animated:YES completion:nil];

}


//弹出链接对话框
- (void)pushLinkAlertView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"链接地址";
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *contentText =  [alertController.textFields firstObject].text;
        self.contentTextView.text = [self.contentTextView.text stringByAppendingString:[NSString stringWithFormat:@"<herf>%@</herf>",contentText]];
        self.contentTextView.selectedRange = NSMakeRange(self.contentTextView.text.length, 0);
    }];
    
    UIAlertAction *cannelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cannelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.images.count <= 3) {
            return  128 + 16 + 86 * (LZYSCREEN_WIDTH - 16) / 359.0;
        }
        else if(self.images.count <= 7){
            return  133 + 16 + 86 * (LZYSCREEN_WIDTH - 16) / 359.0 * 2;
        }
        else{
            return  138 + 16 + 86 * (LZYSCREEN_WIDTH - 16) / 359.0 * 3;
        }
    }

    return 44;
}




- (IBAction)linkClick:(id)sender {
    
    [self pushLinkAlertView];
}


#pragma mark - LGPhotoPickerViewControllerDelegate
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original
{

    for (int i = 0;  i < self.images.count; i++) {
        LZYALAssetModel *model = self.images[i];
        if (model.lgAsset) {
            [self.images removeObject:model];
            i--;
        }
    }
    for (LGPhotoAssets *lgAsset in assets) {
        LZYALAssetModel *model = [[LZYALAssetModel alloc] init];
        model.lgAsset = lgAsset;
        [self.images addObject:model];
    }
    
    [self refreshImages];
    
}



- (NSInteger) numberOfSectionInPhotosInPickerBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser
{
    return 1;
}

/**
 *  每个组多少个图片
 */
- (NSInteger) photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section
{
    return self.browserPhotoArray.count;
}


/**
 *  每个对应的IndexPath展示什么内容
 */
- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath
{

    return self.browserPhotoArray[indexPath.item];
}


#pragma mark -lazy
- (NSMutableArray *)images
{
    if (!_images) {
        _images = @[].mutableCopy;
    }
    return _images;
}


- (NSMutableArray *)browserPhotoArray
{
    if (!_browserPhotoArray) {
        _browserPhotoArray = @[].mutableCopy;
    }
    return _browserPhotoArray;
}



@end
