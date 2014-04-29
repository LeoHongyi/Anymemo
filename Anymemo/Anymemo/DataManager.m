//
//  DataManager.m
//  Anymemo
//
//  Created by pengyunchou on 14-4-26.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "DataManager.h"

@interface DataManager()
@property (nonatomic,strong)FMDatabase* db;
@property (nonatomic,strong)NSDictionary* currentMemo;
@property (nonatomic,strong)NSDictionary *allItems;
@property (nonatomic,strong)NSArray *allcategories;
@property (nonatomic,strong)NSMutableDictionary* downloadedItems;
@property (nonatomic,strong)NSString* downloadItemsSavePath;
@end

@implementation DataManager

-(void)loadData{
    NSData *allitemdata=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"all_items" ofType:@"json"]];
    self.allItems=[NSJSONSerialization JSONObjectWithData:allitemdata options:NSJSONReadingMutableContainers error:nil];
    self.allcategories=[self.allItems allKeys];
    NSData *downlaoditemsdata=[NSData dataWithContentsOfFile:self.downloadItemsSavePath];
    if (downlaoditemsdata!=nil) {
        self.downloadedItems=[NSJSONSerialization JSONObjectWithData:downlaoditemsdata options:NSJSONReadingMutableContainers error:nil];
    }
    if (self.downloadedItems==nil) {
        self.downloadedItems=[NSMutableDictionary dictionary];
    }
}
-(void)removeDownloadItem:(NSString *)key{
    NSDictionary* itemInfo=self.downloadedItems[key];
    NSString* localpath=itemInfo[@"local"];
    NSFileManager* fmgr=[NSFileManager defaultManager];
    [fmgr removeItemAtPath:localpath error:nil];
    [self.downloadedItems removeObjectForKey:key];
    [self saveDownloadItemsToFile];
}
-(void)saveDownloadItemsToFile{
    NSData* downloaditemsdata=[NSJSONSerialization dataWithJSONObject:self.downloadedItems options:NSJSONWritingPrettyPrinted error:nil];
    if (downloaditemsdata) {
        [downloaditemsdata writeToFile:self.downloadItemsSavePath atomically:YES];
    }
}
-(NSDictionary *)getAllDownloadItems{
    return self.downloadedItems;
}
-(void)addDownloadItem:(NSDictionary *)memo savePath:(NSString *)savePath{
    NSDictionary* downloadItem=@{
                                 @"memo":memo,
                                 @"local":savePath
                                 };
    self.downloadedItems[memo[@"Url"]]=downloadItem;
    [self saveDownloadItemsToFile];
}
-(BOOL)isLocal:(NSString *)url{
    return  self.downloadedItems[url]==nil?NO:YES;
}
-(NSDictionary *)getAllItems{
    return  self.allItems;
}
-(NSArray *)getAllCategories{
    return self.allcategories;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.downloadItemsSavePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloads.json"];
        [self loadData];
    }
    return self;
}
-(void)createOkTableIfNotExist{
    if (self.db!=nil) {
        NSString* sql=@"CREATE TABLE IF NOT EXISTS dict_ok(id integer);";
        [self.db executeUpdate:sql];
    }else{
        NSLog(@"db not opend.");
    }
}
-(Quetion *)getRandomQuestion{
    NSString* sql=@"SELECT * FROM dict_tbl ORDER BY RANDOM() LIMIT 1;";
    FMResultSet* rs=[self.db executeQuery:sql];
    if ([rs next]) {
        Quetion *q=[[Quetion alloc] init];
        q.qid=@([rs intForColumn:@"_id"]);
        q.question=[rs stringForColumn:@"question"];
        q.answer=[rs stringForColumn:@"answer"];
        q.note=[rs stringForColumn:@"note"];
        return q;
    }
    return nil;
}
-(void)openMemo:(NSDictionary *)memo{
    if (self.db!=nil) {
        [self.db close];
    }
    self.currentMemo=memo;
    NSString* localpath=memo[@"local"];
    self.db=[FMDatabase databaseWithPath:localpath];
    [self.db open];
    [self createOkTableIfNotExist];
}
+(instancetype)shareManager{
    static DataManager* manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[DataManager alloc] init];
    });
    return manager;
}
@end
