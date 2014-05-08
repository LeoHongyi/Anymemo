//
//  DataManager.h
//  Anymemo
//
//  Created by xxxx on 14-4-26.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quetion.h"

#define MAX_RESENT 3

@interface DataManager : NSObject
-(void)addRecentItem:(NSDictionary *)iteminfo;
-(NSArray *)getRecentItems;
-(NSDictionary *)getAllItems;
-(NSArray *)getAllCategories;
-(NSDictionary *)getAllDownloadItems;
-(BOOL)isLocal:(NSString *)url;
-(void)addDownloadItem:(NSDictionary *)mono savePath:(NSString *)savePath;
-(void)removeDownloadItem:(NSString *)key;
-(void)insertOkTable:(NSNumber *)qid;
-(void)openMemo:(NSDictionary *)memo;
-(Quetion *)getRandomQuestion;
-(NSDictionary *)searchWithKey:(NSString *)key;
+(instancetype)shareManager;
@end
