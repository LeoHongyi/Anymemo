//
//  ConfigManager.h
//  Anymemo
//
//  Created by Leo on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject
-(UIColor *)getCardBackgourndColor;
-(void)setCardBackgroundColor:(UIColor *)c;
-(UIFont *)getCardFont;
-(void)setCardFont:(UIFont *)f;
-(void)setCardFontColor:(UIColor *)c;
-(UIColor *)getCardFontColor;
-(BOOL)isDisplayNote;
-(void)setDisplayNote:(BOOL)d;
+(instancetype)sharedManager;
@end
