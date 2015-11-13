//
//  ConfigManager.m
//  Anymemo
//
//  Created by Leo on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "ConfigManager.h"


@implementation ConfigManager
//r:g:b
-(NSString *)colorToString:(UIColor *)c{
    CGFloat r,g,b,a;
    [c getRed:&r green:&g blue:&b alpha:&a];
    return [NSString stringWithFormat:@"%f:%f:%f",r,g,b];
}
-(UIColor *)stringToColor:(NSString *)s{
    NSArray* rgb=[s componentsSeparatedByString:@":"];
    float r,g,b;
    r=[rgb[0] floatValue];
    g=[rgb[1] floatValue];
    b=[rgb[2] floatValue];
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
-(UIColor *)getCardBackgourndColor{
    NSString* colorstr=[[NSUserDefaults standardUserDefaults] valueForKey:@"CardBackgourndColor"];
    if (colorstr==nil) {
        return [UIColor whiteColor];
    }
    return [self stringToColor:colorstr];
}
-(void)setCardBackgroundColor:(UIColor *)c{
    NSString* colorstr=[self colorToString:c];
    NSLog(@"%@",colorstr);
    [[NSUserDefaults standardUserDefaults] setValue:colorstr forKey:@"CardBackgourndColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setCardFontColor:(UIColor *)c{
    NSString* colorstr=[self colorToString:c];
    [[NSUserDefaults standardUserDefaults] setValue:colorstr forKey:@"CardFontColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(UIColor *)getCardFontColor{
    NSString* colorstr=[[NSUserDefaults standardUserDefaults] valueForKey:@"CardFontColor"];
    if (colorstr==nil) {
        return [UIColor whiteColor];
    }
    return [self stringToColor:colorstr];
}
-(UIFont *)getCardFont{
    NSNumber* cardFontSize= [[NSUserDefaults standardUserDefaults] objectForKey:@"cardFontSize"];
    NSString* family=[[NSUserDefaults standardUserDefaults] objectForKey:@"cardFontFamily"];
    if (cardFontSize==nil) {
        cardFontSize=@(15);
        family=@"";
    }
    return [UIFont fontWithName:family size:[cardFontSize floatValue]];
}
-(void)setCardFont:(UIFont *)f{
    NSNumber* cardFontSize=@([f pointSize]);
    [[NSUserDefaults standardUserDefaults] setObject:cardFontSize forKey:@"cardFontSize"];
    [[NSUserDefaults standardUserDefaults] setObject:f.familyName forKey:@"cardFontFamily"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isDisplayNote{
    NSNumber* d= [[NSUserDefaults standardUserDefaults] objectForKey:@"isDisplayNote"];
    return [d boolValue];
}
-(void)setDisplayNote:(BOOL)d{
    [[NSUserDefaults standardUserDefaults] setObject:@(d) forKey:@"isDisplayNote"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(instancetype)sharedManager{
    static ConfigManager* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[ConfigManager alloc] init];
    });
    return manager;
}
@end
