//
//  AnswerView.m
//  Anymemo
//
//  Created by pengyunchou on 14-4-30.
//  Copyright (c) 2014年 skysent. All rights reserved.
//

#import "AnswerView.h"

@interface AnswerView()
@property (nonatomic,strong)UIView* questionContainer;
@property (nonatomic,strong)UIView* answerContainer;
@property (nonatomic,strong)UILabel* questionLabel;
@property (nonatomic,strong)UIButton* forgetBtn;
@property (nonatomic,strong)UIButton*remenberBtn;
@property (nonatomic,strong)UILabel* answerLabel;
@property (nonatomic,strong)UIButton* nextBtn;
@end

@implementation AnswerView

-(void)setupStyleForContainerView:(UIView *)view{
    view.backgroundColor=[UIColor whiteColor];
    view.layer.shadowColor=[[UIColor lightGrayColor] CGColor];
    view.layer.shadowOffset=CGSizeMake(5, 5);
    view.layer.shadowRadius=5;
    view.layer.shadowOpacity=0.7;
    view.layer.cornerRadius=10;
}

-(void)setupSubviews{
    self.questionContainer=[[UIView alloc] initWithFrame:self.bounds];
    [self setupStyleForContainerView:self.questionContainer];
    [self  addSubview:self.questionContainer];
    self.questionContainer.backgroundColor=[UIColor whiteColor];
    self.remenberBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, self.questionContainer.frame.size.height-54, (self.questionContainer.frame.size.width-30)/2, 44)];
    self.forgetBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.remenberBtn.frame.origin.x+self.remenberBtn.frame.size.width+10, self.questionContainer.frame.size.height-54, (self.questionContainer.frame.size.width-30)/2, 44)];
    self.remenberBtn.backgroundColor=[UIColor greenColor];
    self.forgetBtn.backgroundColor=[UIColor redColor];
    
    [self.remenberBtn setTitle:@"记住了" forState:UIControlStateNormal];
    [self.forgetBtn setTitle:@"忘记了" forState:UIControlStateNormal];
    self.forgetBtn.layer.cornerRadius=5;
    self.remenberBtn.layer.cornerRadius=5;
    [self.questionContainer addSubview:self.remenberBtn];
    [self.questionContainer addSubview:self.forgetBtn];
    
    [self.remenberBtn addTarget:self action:@selector(onRememberBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn addTarget:self action:@selector(onForgetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.questionLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    self.questionLabel.numberOfLines=0;
    self.questionLabel.font=[UIFont systemFontOfSize:25];
    self.questionLabel.textColor=[UIColor darkGrayColor];
    self.questionLabel.lineBreakMode=NSLineBreakByWordWrapping;
    self.questionLabel.textAlignment=NSTextAlignmentCenter;
    [self.questionContainer addSubview:self.questionLabel];
    
    self.answerContainer=[[UIView alloc] initWithFrame:self.bounds];
    [self setupStyleForContainerView:self.answerContainer];
    //self.answerContainer.backgroundColor=[UIColor redColor];
    self.answerContainer.hidden=YES;
    [self insertSubview:self.answerContainer belowSubview:self.questionContainer];
    self.answerLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    self.answerLabel.numberOfLines=0;
    self.answerLabel.font=[UIFont systemFontOfSize:25];
    self.answerLabel.textColor=[UIColor darkGrayColor];
    self.answerLabel.lineBreakMode=NSLineBreakByWordWrapping;
    self.answerLabel.textAlignment=NSTextAlignmentCenter;
    [self.answerContainer addSubview:self.answerLabel];
    self.nextBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, self.answerContainer.frame.size.height-54, self.answerContainer.frame.size.width-20, 44)];
    [self.nextBtn setTitle:@"下一条" forState:UIControlStateNormal];
    self.nextBtn.backgroundColor=[UIColor greenColor];
    self.nextBtn.layer.cornerRadius=5;
    [self.nextBtn addTarget:self action:@selector(onNextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.answerContainer addSubview:self.nextBtn];
}
-(void)flip{
    if (self.isRemember) {
        self.nextBtn.hidden=YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goNext];
        });
    }else{
        self.nextBtn.hidden=NO;
    }
    [UIView animateWithDuration:1 animations:^{
        self.answerContainer.hidden=NO;
        self.questionContainer.hidden=YES;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:self cache:YES];
    } completion:nil];
}
-(void)goNext{
    NSLog(@"go next");
}
-(void)onNextBtnClicked:(UIButton *)btn{
    [self goNext];
}
-(void)onRememberBtnClicked:(UIButton *)btn{
    self.isRemember=YES;
    [self flip];
}
-(void)onForgetBtnClicked:(UIButton *)btn{
    self.isRemember=NO;
    [self flip];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}
-(CGSize )heightForText:(UILabel *)label{
    float questionLabelWidth=self.questionContainer.frame.size.width-20;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:self.questionLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [label.text boundingRectWithSize:CGSizeMake(questionLabelWidth, self.questionContainer.frame.size.height-54) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}
-(void)setInfoWithQuestion:(Quetion *)question{
    self.questionLabel.text=question.question;
    
    CGSize questionsize=[self heightForText:self.questionLabel];
    self.questionLabel.frame=CGRectMake(0,0, questionsize.width, questionsize.height);
    self.questionLabel.center=CGPointMake(self.questionContainer.center.x, self.questionContainer.center.y-44-10);
    
    self.answerLabel.text=question.answer;
    CGSize answersize=[self heightForText:self.answerLabel];
    self.answerLabel.frame=CGRectMake(0,0, answersize.width, answersize.height);
    self.answerLabel.center=CGPointMake(self.answerContainer.center.x, self.answerContainer.center.y-44-10);
}


@end
