//
//  RecentViewController.h
//  Anymemo
//
//  Created by pengyunchou on 14-5-7.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
