//
//  CardBackgroundPickerViewController.m
//  Anymemo
//
//  Created by pengyunchou on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "ColorPickerViewController.h"
//#import "Palette.h"
#import "NKOColorPickerView.h"
#import "ConfigManager.h"
@interface ColorPickerViewController ()
//@property (nonatomic,strong)Palette* colorPanel;
@property (nonatomic,strong)NKOColorPickerView *colorPicker;
@property (nonatomic,strong)UIView* currentColor;
@end

@implementation ColorPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)changeColor:(UIColor *)_color{
    self.currentColor.backgroundColor=_color;
    self.onColorChangeCb(_color);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.colorPanel=[[Palette alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    self.colorPicker=[[NKOColorPickerView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.width) color:self.startColor andDidChangeColorBlock:^(UIColor *color) {
        //self.onColorChangeCb(color);
        [self changeColor:color];
    }];
    [self.view addSubview:self.colorPicker];
//    self.colorPanel.center=self.view.center;
//    self.colorPanel.paletteDelegate=self;
    
    self.currentColor=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.colorPicker.frame.origin.y+self.colorPicker.frame.size.height+10, 40, 20)];
    self.currentColor.backgroundColor=self.startColor;
    [self.view addSubview:self.currentColor];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
