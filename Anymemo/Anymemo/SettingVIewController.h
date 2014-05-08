//
//  SettingVIewController.h
//  Anymemo
//
//  Created by xxxx on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingVIewController : UITableViewController
- (IBAction)displayNoteSwitchValueCanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *displayNoteSwitch;

@end
