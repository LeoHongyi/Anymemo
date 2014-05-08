//
//  FKViewController.m
//  MyBrowser
//
//  Created by yeeku on 13-6-13.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "webViewController.h"

@interface UIViewController ()

@end

@implementation webViewController
UIActivityIndicatorView* activityIndicator;
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.webView.scalesPageToFit = YES;
	
	self.webView.delegate = self;
	
	activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
	
	[activityIndicator setCenter: self.view.center] ;
	activityIndicator.activityIndicatorViewStyle
    = UIActivityIndicatorViewStyleWhiteLarge;
	[self.view addSubview : activityIndicator];
	
	activityIndicator.hidden = YES;
	[self goClicked:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	
	activityIndicator.hidden = NO;	[activityIndicator startAnimating] ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	
	[activityIndicator stopAnimating];
	
	activityIndicator.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
	[alert show];
}
- (IBAction)goClicked:(id)sender {
	[self.addr resignFirstResponder];

	NSString* reqAddr = self.addr.text;
	
	if (![reqAddr hasPrefix:@"http://"]) {
		reqAddr = [NSString stringWithFormat:@"http://%@" , reqAddr];
		self.addr.text = reqAddr;
	}
	NSURLRequest* request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:reqAddr]];
	
	[self.webView loadRequest:request];
}
@end
