//
//  webViewController.h
//  Anymemo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addr;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)goClicked:(id)sender;

@end
