//
//  OpenTableViewController.h
//  Anymemo
//
//  Created by Leo on 14-4-26.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
- (IBAction)editBtnClicked:(id)sender;

@end
