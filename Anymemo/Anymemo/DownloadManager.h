//
//  DownloadManager.h
//  Anymemo
//
//  Created by Leo on 14-4-24.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^onDownlaodProgress) (float progress);
typedef void(^onDownloadComplete) (BOOL success,id parmeter);

@interface DownloadManager : NSObject

-(void)downloadMemo:(NSDictionary *)memoinfo onProgress:(onDownlaodProgress) progresscb onComplete:(onDownloadComplete)completecb;

+(instancetype)sharedManager;
@end
