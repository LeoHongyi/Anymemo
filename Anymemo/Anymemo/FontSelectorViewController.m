//
//  FontSelectorViewController.m
//  Anymemo
//
//  Created by pengyunchou on 14-5-10.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "FontSelectorViewController.h"

@interface FontSelectorViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)NSArray* familyNames;
@property (nonatomic,strong)NSString* currentFontName;
@property (nonatomic,strong)NSNumber* currentFontSize;
@end

@implementation FontSelectorViewController
-(void)getAllFontNames{
    self.familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView==self.stylePicker) {
        return [self.familyNames objectAtIndex:row];
    }else{
        return [NSString stringWithFormat:@"%d",10+row];
    }
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==self.stylePicker) {
        return [self.familyNames count];
    }else{
        return 20;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView==self.stylePicker) {
        self.currentFontName=self.familyNames[row];
    }else{
        self.currentFontSize=@(10+row);
    }
    if (self.currentFontSize==nil) {
        self.currentFontSize=@(10);
    }
    if (self.onFontChanged) {
        UIFont *f=[UIFont fontWithName:self.currentFontName size:[self.currentFontSize floatValue]];
        self.onFontChanged(f);
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAllFontNames];
    int familyLine=0;
    for (int i=0; i<[self.familyNames count]; i++) {
        if ([self.startFontName isEqualToString:self.familyNames[i]]) {
            familyLine=i;
            break;
        }
    }
    [self.stylePicker selectRow:familyLine inComponent:0 animated:YES];
    int line=[self.startFontSize intValue]-10;
    if (line<0) {
        line=0;
    }
    if (line>19) {
        line=19;
    }
    [self.sizePicker selectRow:line inComponent:0 animated:YES];
    // Do any additional setup after loading the view.
}


@end
