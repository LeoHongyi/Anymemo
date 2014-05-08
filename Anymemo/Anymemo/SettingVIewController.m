//
//  SettingVIewController.m
//  Anymemo
//
//  Created by xxxx on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "SettingVIewController.h"
#import "ConfigManager.h"
#import "CardBackgroundPickerViewController.h"
@interface SettingVIewController ()

@end

@implementation SettingVIewController

-(void)showBackgoundSelectView{
    CardBackgroundPickerViewController* bgs=[self.storyboard instantiateViewControllerWithIdentifier:@"CardBackgroundPickerViewController"];
    bgs.onColorChangeCb=^(UIColor *c){
        [[ConfigManager sharedManager] setCardBackgroundColor:c];
    };
    [self.navigationController pushViewController:bgs animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        [self showBackgoundSelectView];
    }else if(indexPath.row==4){
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"AnyMemo beta 1.0"
                                                      message:@"记忆辅助软件 作者：小P Leo 官网：anymemo.org"
                             
                                                     delegate:nil
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定",nil];
        [alert show];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.displayNoteSwitch.on=[[ConfigManager sharedManager] isDisplayNote];
}

- (IBAction)displayNoteSwitchValueCanged:(id)sender {
    [[ConfigManager sharedManager] setDisplayNote:self.displayNoteSwitch.isOn];
}

@end
