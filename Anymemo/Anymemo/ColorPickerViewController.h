//
//  CardBackgroundPickerViewController.h
//  Anymemo
//
//  Created by pengyunchou on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPickerViewController : UIViewController
@property (nonatomic,strong)UIColor *startColor;
@property (nonatomic,strong) void(^onColorChangeCb)(UIColor *c);
@end
