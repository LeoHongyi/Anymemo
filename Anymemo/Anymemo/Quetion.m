//
//  Quetion.m
//  Anymemo
//
//  Created by xxxx on 14-4-29.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "Quetion.h"

@implementation Quetion
-(NSString *)description{
    return [NSString stringWithFormat:@"%@, %@, %@, %@",self.qid,self.question,self.answer,self.note];
}
@end
