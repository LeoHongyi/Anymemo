//
//  DownloadDetailTableViewController.m
//  Anymemo
//
//  Created by Leo on 14-4-21.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "DownloadDetailTableViewController.h"
#import "DownloadCell.h"
#import "DownloadManager.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "DataManager.h"
@interface DownloadDetailTableViewController ()
@property (nonatomic,strong)MBProgressHUD *hud;
@end

@implementation DownloadDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"列表";
    self.hud=[[MBProgressHUD alloc] initWithView:self.navigationController.view];
    self.hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [self.navigationController.view addSubview:self.hud];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.memos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadCell" forIndexPath:indexPath];
    NSDictionary* memoinfo=self.memos[indexPath.row];
    cell.memo=memoinfo;
    cell.titleLabel.text=memoinfo[@"Name"];
    cell.descLabel.text=memoinfo[@"Author"];
    cell.downloadCb=^(DownloadCell *cell){
        [self.hud show:YES];
        [[DownloadManager sharedManager] downloadMemo:cell.memo onProgress:^(float progress) {
            NSLog(@"%f",progress);
            self.hud.progress=progress;
        } onComplete:^(BOOL success,id parameter) {
            if (success) {
//                NSLog(@"download complete:%@\n savepath:%@",cell.memo,parameter);
                [[DataManager shareManager] addDownloadItem:cell.memo savePath:parameter];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            }
            [self.hud hide:YES];
        }];
    };
    BOOL islocal=[[DataManager shareManager] isLocal:memoinfo[@"Url"]];
    [cell setLocal:islocal];
    return cell;
}

@end
