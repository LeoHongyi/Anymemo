//
//  OpenTableViewController.m
//  Anymemo
//
//  Created by Leo on 14-4-26.
//  Copyright (c) 2014年 skysent. All rights reserved.
//
#import "DataManager.h"
#import "OpenTableViewController.h"
#import "DetailViewController.h"
@interface OpenTableViewController ()
@property BOOL isEditing;
@property (nonatomic,strong)NSDictionary *downloadItems;
@end

@implementation OpenTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)editBtnClicked:(id)sender {
    self.isEditing=!self.isEditing;
    self.editBtn.title=self.isEditing?@"完成":@"编辑";
    [self.tableView setEditing:self.isEditing animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UITableViewCellEditingStyleDelete==editingStyle) {
        [self deleteDownloadItemAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    NSArray* allitemkesy=[self.downloadItems allKeys];
    NSString* key=allitemkesy[indexPath.row];
    NSDictionary* memo=self.downloadItems[key];
    [[DataManager shareManager] addRecentItem:memo];
    detail.memo=memo;
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)deleteDownloadItemAtIndex:(int)index{
    NSArray* allitemkesy=[self.downloadItems allKeys];
    NSString* key=allitemkesy[index];
    [[DataManager shareManager] removeDownloadItem:key];
    self.downloadItems=[[DataManager shareManager] getAllDownloadItems];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"打开";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.downloadItems=[[DataManager shareManager] getAllDownloadItems];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.downloadItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OpenCell" forIndexPath:indexPath];
    NSArray* allitemkesy=[self.downloadItems allKeys];
    NSDictionary *itemInfo=self.downloadItems[allitemkesy[indexPath.row]];
    NSDictionary* memoinfo=itemInfo[@"memo"];
    cell.textLabel.text=memoinfo[@"Name"];
    cell.detailTextLabel.text=memoinfo[@"Author"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
