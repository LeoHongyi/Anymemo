//
//  DownloadManager.m
//  Anymemo
//
//  Created by Leo on 14-4-24.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "DownloadManager.h"
#import "AFNetworking/AFNetworking.h"

@interface DownloadManager()
@property (nonatomic,strong)onDownlaodProgress downloadProgress;
@end

@implementation DownloadManager



-(void)downloadMemo:(NSDictionary *)memoinfo onProgress:(onDownlaodProgress) progresscb onComplete:(onDownloadComplete)completecb{
    self.downloadProgress=progresscb;
    NSLog(@"%s downlaod memo %@",__FUNCTION__,memoinfo);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            
            NSURL *URL = [NSURL URLWithString:memoinfo[@"Url"]];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            NSProgress *progress;
            NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                NSLog(@"File downloaded to: %@", [filePath path]);
                if (error!=nil) {
                    completecb(NO,nil);
                }else{
                    completecb(YES,[filePath path]);
                }
            }];
            [progress addObserver:self
                       forKeyPath:@"fractionCompleted"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
            [downloadTask resume];
        });
    });
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"fractionCompleted"]) {
        NSProgress *progress = (NSProgress *)object;
        //NSLog(@"Progress… %f", progress.fractionCompleted);
        self.downloadProgress(progress.fractionCompleted);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
+(instancetype)sharedManager{
    static DownloadManager* _sharedmanager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedmanager=[[DownloadManager alloc] init];
    });
    return _sharedmanager;
}
@end
