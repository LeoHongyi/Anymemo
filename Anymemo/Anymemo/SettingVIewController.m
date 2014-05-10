//
//  SettingVIewController.m
//  Anymemo
//
//  Created by xxxx on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "SettingVIewController.h"
#import "ConfigManager.h"
#import "ColorPickerViewController.h"
#import "FontSelectorViewController.h"
@interface SettingVIewController ()<UIAlertViewDelegate>

@end

@implementation SettingVIewController

-(void)showBackgoundSelectView{
    ColorPickerViewController* bgs=[self.storyboard instantiateViewControllerWithIdentifier:@"CardBackgroundPickerViewController"];
    bgs.startColor=[[ConfigManager sharedManager] getCardBackgourndColor];
    bgs.onColorChangeCb=^(UIColor *c){
        [[ConfigManager sharedManager] setCardBackgroundColor:c];
    };
    [self.navigationController pushViewController:bgs animated:YES];
}
-(void)selfShowFontColorView{
    ColorPickerViewController* bgs=[self.storyboard instantiateViewControllerWithIdentifier:@"CardBackgroundPickerViewController"];
    bgs.startColor=[[ConfigManager sharedManager] getCardFontColor];
    bgs.onColorChangeCb=^(UIColor *c){
        [[ConfigManager sharedManager] setCardFontColor:c];
    };
    [self.navigationController pushViewController:bgs animated:YES];
}
-(void)selfShowFontSelectView{
    FontSelectorViewController *selectView=[self.storyboard instantiateViewControllerWithIdentifier:@"FontSelectorViewController"];
    selectView.onFontChanged=^(UIFont *f){
        [[ConfigManager sharedManager] setCardFont:f];
    };
    selectView.startFontSize=@([[[ConfigManager sharedManager] getCardFont] pointSize]);
    selectView.startFontName=[[[ConfigManager sharedManager] getCardFont] familyName];
    [self.navigationController pushViewController:selectView animated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self performSegueWithIdentifier:@"openSite" sender:self];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        [self showBackgoundSelectView];
    }else if(indexPath.row==1){
        [self selfShowFontColorView];
    }else if(indexPath.row==2){
        [self selfShowFontSelectView];
    }else if(indexPath.row==5){
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"AnyMemo beta 1.0"
                                                      message:@"记忆辅助软件 作者：小P Leo 官网：anymemo.org"
                             
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"打开官网",nil];
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
