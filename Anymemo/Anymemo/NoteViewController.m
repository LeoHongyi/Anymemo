//
//  NoteViewController.m
//  Anymemo
//
//  Created by pengyunchou on 14-5-10.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "NoteViewController.h"
#import "DataManager.h"
@interface NoteViewController ()

@end

@implementation NoteViewController

-(void)viewWillAppear:(BOOL)animated{
    self.noteTextView.text=self.question.note;
}

- (IBAction)onCompleteBtnClicked:(id)sender {
    self.question.note=self.noteTextView.text;
    [[DataManager shareManager] updateQuestion:self.question];
    if (self.onComplete) {
        self.onComplete();
    }
}
@end
