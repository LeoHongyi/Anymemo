//
//  AnswerView.h
//  Anymemo
//
//  Created by pengyunchou on 14-4-30.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quetion.h"
@interface AnswerView : UIView
-(void)setInfoWithQuestion:(Quetion *)question;
@property BOOL isRemember;
@end
