//
//  DetailViewController.m
//  Anymemo
//
//  Created by xxxx on 14-4-29.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "DetailViewController.h"
#import "DataManager.h"
#import "AnswerView.h"
#import "ConfigManager.h"
#import "NoteViewController.h"
@interface DetailViewController ()
@property (nonatomic,strong)Quetion* currentQuestion;
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
-(void)alertComplete{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"你已经完成了所有卡片记忆！" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)setupAnswerViewStyle {
    [self.currentAnswerview setCardColor:[[ConfigManager sharedManager] getCardBackgourndColor]];
    [self.currentAnswerview setFontColor:[[ConfigManager sharedManager] getCardFontColor]];
    [self.currentAnswerview setFont:[[ConfigManager sharedManager] getCardFont]];
}

-(void)goNextAnserView{
    DetailViewController* me=self;
    AnswerView* oldview=me.currentAnswerview;
    me.currentAnswerview=[[AnswerView alloc] initWithFrame:CGRectMake(10+320, 74, me.view.frame.size.width-20, me.view.frame.size.height-134)];
    [self setupAnswerViewStyle];
    NSLog(@"%@",[[ConfigManager sharedManager] getCardBackgourndColor]);
    self.currentQuestion=[[DataManager shareManager] getRandomQuestion];
    if (self.currentQuestion==nil) {
        [self alertComplete];
        return;
    }
    [me.currentAnswerview setInfoWithQuestion:self.currentQuestion];
    me.currentAnswerview.onRememberCb=^(Quetion *q){
        [self onRemember:q];
    };
    self.currentAnswerview.onNextCb=^{
        [me goNextAnserView];
    };
    [me.view addSubview:me.currentAnswerview];
    [UIView animateWithDuration:1 animations:^{
        oldview.frame=CGRectMake(-320, 20, me.view.frame.size.width-20, me.view.frame.size.height-134);
        me.currentAnswerview.frame=CGRectMake(10, 74, me.view.frame.size.width-20, me.view.frame.size.height-134);
    } completion:^(BOOL finished) {
        [oldview removeFromSuperview];
    }];
}
-(void)onRemember:(Quetion *)q{
    [[DataManager shareManager] insertOkTable:q.qid];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    DetailViewController* me=self;
    self.title=@"记忆";
    [[DataManager shareManager] openMemo:self.memo];
    self.currentAnswerview=[[AnswerView alloc] initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, self.view.frame.size.height-134)];
    [self setupAnswerViewStyle];
    self.currentQuestion=[[DataManager shareManager] getRandomQuestion];
    if (self.currentQuestion==nil) {
        [self alertComplete];
        return;
    }
    [self.currentAnswerview setInfoWithQuestion:self.currentQuestion];
    self.currentAnswerview.onRememberCb=^(Quetion *q){
        [me onRemember:q];
    };
    [self.view addSubview:self.currentAnswerview];
    self.currentAnswerview.onNextCb=^{
        [me goNextAnserView];
    };
    if ([[ConfigManager sharedManager] isDisplayNote]) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"笔记" style:UIBarButtonItemStylePlain target:self action:@selector(onNoteBtnClicked)];
    }
    
    // Do any additional setup after loading the view.
}
-(void)onNoteBtnClicked{
    NoteViewController *ntv=[self.storyboard instantiateViewControllerWithIdentifier:@"NoteViewController"];
    ntv.memo=self.memo;
    ntv.question=self.currentQuestion;
    ntv.onComplete=^{
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:ntv animated:YES];
    //[self presentViewController:ntv animated:YES completion:nil];
//    UINavigationController* nav=[self.storyboard instantiateViewControllerWithIdentifier:@"NoteNav"];
//    NoteViewController *ntv=(NoteViewController *)nav.topViewController;
//        ntv.memo=self.memo;
//        ntv.question=self.currentQuestion;
//        ntv.onComplete=^{
//            [self dismissViewControllerAnimated:YES completion:nil];
//        };
//    [self presentViewController:nav animated:YES completion:nil];
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
