//
//  LZYPDFReaderViewController.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/20.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYPDFReaderViewController.h"
#import "ReaderViewController.h"
#import "XXPath.h"
#import "UIView+NetLoadView.h"
@interface LZYPDFReaderViewController ()<ReaderViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LZYPDFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setUp];
    
    [self loadSourceData];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSourceData
{

    [self.view beginLoading];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [XXPath docPath];
    NSMutableArray *musicFiles = [NSMutableArray array];
    NSError *error = nil;
    NSArray *names = [manager contentsOfDirectoryAtPath:path error:&error];
    if (!error)
    {
        for (NSString *name in names)
        {
            if ([name hasSuffix:@".pdf"])
            {
                NSString *filepath = [path stringByAppendingPathComponent:name];
                [musicFiles addObject:filepath];
            }
        }
    }else{
    
        [self.view loadError];
    }
    
    if (musicFiles.count == 0) {
        [self.view loadNone];
    }
    else{
        [self.view endLoading];
    }
    self.dataSource = [musicFiles mutableCopy];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PDFBookListCell" forIndexPath:indexPath];
    NSString *path = self.dataSource[indexPath.row];
    NSString *fileName = [path lastPathComponent];
    cell.textLabel.text = fileName;
    cell.imageView.image = [UIImage imageNamed:@"AppIcon-076.png"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self goToReaderWithSourcesName:self.dataSource[indexPath.row]];
}



- (void)goToReaderWithSourcesName:(NSString *)filePath
{
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    assert(filePath != nil); // Path to first PDF file
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
        [self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:YES completion:NULL];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
    }
    else // Log an error so that we know that something went wrong
    {
        NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
    }
}


#pragma mark - ReaderViewControllerDelegate methods
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
    [self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
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
