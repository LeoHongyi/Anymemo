//
//  DataManager.h
//  Anymemo
//
//  Created by pengyunchou on 14-4-26.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quetion.h"
@interface DataManager : NSObject
-(NSDictionary *)getAllItems;
-(NSArray *)getAllCategories;
-(NSDictionary *)getAllDownloadItems;
-(BOOL)isLocal:(NSString *)url;
-(void)addDownloadItem:(NSDictionary *)mono savePath:(NSString *)savePath;
-(void)removeDownloadItem:(NSString *)key;
-(void)openMemo:(NSDictionary *)memo;
-(Quetion *)getRandomQuestion;
+(instancetype)shareManager;
@end
