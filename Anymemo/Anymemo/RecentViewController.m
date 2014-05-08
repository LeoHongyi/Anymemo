//
//  RecentViewController.m
//  Anymemo
//
//  Created by xxxx on 14-5-7.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "RecentViewController.h"
#import "DataManager.h"
#import "DetailViewController.h"
@interface RecentViewController ()
@property (nonatomic,strong)NSMutableArray* recentItems;
@end

@implementation RecentViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.recentItems=[NSMutableArray array];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray* items=[[DataManager shareManager] getRecentItems];
    [self.recentItems removeAllObjects];
    for (int i=[items count]-1; i>=0; i--) {
        [self.recentItems addObject:items[i]];
    }
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.recentItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RecentCell"];
    NSDictionary* memo=[self.recentItems objectAtIndex:indexPath.row][@"memo"];
    cell.textLabel.text=memo[@"Name"];
    cell.detailTextLabel.text=memo[@"Author"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    NSDictionary* memo=self.recentItems[indexPath.row];
    [[DataManager shareManager] addRecentItem:memo];
    detail.memo=memo;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
