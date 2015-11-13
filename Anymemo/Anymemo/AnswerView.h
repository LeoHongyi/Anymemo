//
//  AnswerView.h
//  Anymemo
//
//  Created by Leo on 14-4-30.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quetion.h"
@interface AnswerView : UIView
@property (nonatomic,strong)void (^onNextCb)(void);
@property (nonatomic,strong)void (^onRememberCb)(Quetion *q);
-(void)setInfoWithQuestion:(Quetion *)question;
@property BOOL isRemember;
-(void)setCardColor:(UIColor *)c;
-(void)setFontColor:(UIColor *)c;
-(void)setFont:(UIFont *)f;
@end
