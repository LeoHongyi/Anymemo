//
//  DownloadCell.m
//  Anymemo
//
//  Created by pengyunchou on 14-4-21.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "DownloadCell.h"

@implementation DownloadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLocal:(BOOL)islocal{
    if (islocal) {
        self.downloadBtn.hidden=YES;
    }else{
        self.downloadBtn.hidden=NO;
    }
}
- (IBAction)downloadBtnClicked:(id)sender {
    NSLog(@"downlaod btn clicked");
    if (self.downloadCb!=nil) {
        self.downloadCb(self);
    }
}
@end
