//
//  DownloadCell.h
//  Anymemo
//
//  Created by pengyunchou on 14-4-21.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownloadCell;

typedef void(^onDownloadCellClickedCb)(DownloadCell *cell);

@interface DownloadCell : UITableViewCell
@property (nonatomic,strong)NSDictionary* memo;
@property (nonatomic,strong)onDownloadCellClickedCb downloadCb;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
- (IBAction)downloadBtnClicked:(id)sender;

@end
