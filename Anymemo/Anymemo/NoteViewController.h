//
//  NoteViewController.h
//  Anymemo
//
//  Created by pengyunchou on 14-5-10.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quetion.h"
@interface NoteViewController : UIViewController
@property (nonatomic,strong)NSDictionary* memo;
@property (nonatomic,strong)Quetion* question;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (nonatomic,strong)void(^onComplete)(void);
- (IBAction)onCompleteBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
