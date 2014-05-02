//
//  DetailViewController.m
//  Anymemo
//
//  Created by pengyunchou on 14-4-29.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "DetailViewController.h"
#import "DataManager.h"
#import "AnswerView.h"
@interface DetailViewController ()
@property (nonatomic,strong)AnswerView* currentAnswerview;
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"记忆";
    self.currentAnswerview=[[AnswerView alloc] initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, self.view.frame.size.height-134)];
    [self.view addSubview:self.currentAnswerview];
    
    [[DataManager shareManager] openMemo:self.memo];
    [self.currentAnswerview setInfoWithQuestion:[[DataManager shareManager] getRandomQuestion]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
