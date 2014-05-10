//
//  FontSelectorViewController.h
//  Anymemo
//
//  Created by pengyunchou on 14-5-10.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontSelectorViewController : UIViewController
@property (nonatomic,strong)void (^onFontChanged)(UIFont *f);
@property (weak, nonatomic) IBOutlet UIPickerView *stylePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *sizePicker;
@property (nonatomic,strong)NSNumber* startFontSize;
@property (nonatomic,strong)NSString* startFontName;
@end
