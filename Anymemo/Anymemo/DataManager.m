//
//  DataManager.m
//  Anymemo
//
//  Created by xxxx on 14-4-26.
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
@property (nonatomic,strong)NSString* recentSavePath;
@property (nonatomic,strong)NSMutableArray *recentItems;
@end

@implementation DataManager
-(void)addRecentItem:(NSDictionary *)iteminfo{
    for (NSDictionary* lmomo in self.recentItems) {
        NSDictionary* memo=lmomo[@"memo"];
        
        if ([iteminfo[@"memo"][@"Name"]  isEqualToString:memo[@"Name"]]) {
            [self.recentItems removeObject:lmomo];
            [self.recentItems addObject:iteminfo];
            return;
        }
    }
    [self.recentItems addObject:iteminfo];
    if ([self.recentItems count]>MAX_RESENT) {
        [self.recentItems removeObjectAtIndex:0];
    }
    [self saveRecentItemsToFile];
}
-(void)saveRecentItemsToFile{
    NSData* recentItemsdata=[NSJSONSerialization dataWithJSONObject:self.recentItems options:NSJSONWritingPrettyPrinted error:nil];
    if (recentItemsdata) {
        [recentItemsdata writeToFile:self.recentSavePath atomically:YES];
    }
}
-(NSArray *)getRecentItems{
    return self.recentItems;
}
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
    NSData* recentdata=[NSData dataWithContentsOfFile:self.recentSavePath];
    if (recentdata!=nil) {
        self.recentItems=[NSJSONSerialization JSONObjectWithData:recentdata options:NSJSONReadingMutableContainers error:nil];
    }
    //NSLog(@"%@",self.recentItems);
    if (self.recentItems==nil) {
        self.recentItems=[NSMutableArray array];
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
        self.recentSavePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/recent.json"];
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
-(void)insertOkTable:(NSNumber *)qid{
    NSString* sql=[NSString stringWithFormat:@"insert into dict_ok(id) values(%@)",qid];
    [self.db executeUpdate:sql];
}
-(Quetion *)getRandomQuestion{
    NSString* sql=@"select * from dict_tbl where _id not in (select id from dict_ok) ORDER BY RANDOM() LIMIT 1;";
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
-(NSDictionary *)searchWithKey:(NSString *)akey{
    if ([akey length]==0) {
        return self.allItems;
    }else{
        NSString* key=[akey lowercaseString];
        NSMutableDictionary* searchresult=[NSMutableDictionary dictionary];
        for (NSString*category in self.allItems) {
            NSDictionary *categoryitems=self.allItems[category];
            NSMutableArray *searchItems=[NSMutableArray array];
            for (NSDictionary* iteminfo in categoryitems) {
                NSString* name=[iteminfo[@"Name"] lowercaseString];
                NSString* author=[iteminfo[@"Author"] lowercaseString];
                if (name==nil||author==nil) {
                    continue;
                }
                if ([name rangeOfString:key].location!=NSNotFound||[author rangeOfString:key].location!=NSNotFound) {
                    [searchItems addObject:iteminfo];
                }
            }
            if ([searchItems count]>0) {
                searchresult[category]=searchItems;
            }
        }
        
        return searchresult;
    }
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
