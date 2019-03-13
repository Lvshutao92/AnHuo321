//
//  IssueViewController.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/13.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import "IssueViewController.h"
#import "MKComposePhotosView.h"
#import "MKMessagePhotoView.h"
@interface IssueViewController ()<UITextFieldDelegate,MKMessagePhotoViewDelegate>
{
    UIView *dhView;
    
    UIScrollView *scrollview;
    UITextField *text1;
    
    UIView *head1BGView;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    
    UIView *head2BGView;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    
    MKMessagePhotoView *photoview;
}

@property (nonatomic, strong) MKMessagePhotoView *photosView;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布商品";
    
    [self setupview];
}
- (void)clickFaBu{
    
    
    NSLog(@"-----%@",photoview.imgsArr);
    
}
//实现代理方法
-(void)addPicker:(UIImagePickerController *)picker{
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)addUIImagePicker:(UIImagePickerController *)picker{
    
    [self presentViewController:picker animated:YES completion:nil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}

- (void)setupview{
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7, SCREEN_WIDTH, SCREEN_HEIGHT-kNavBarHAbove7)];
    [self.view addSubview:scrollview];
    
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
    text1.placeholder = @"请输入商品名称";
    text1.delegate = self;
    text1.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    UILabel *head1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 35)];
    head1.text = @"商品详情";
    head1.textAlignment = NSTextAlignmentCenter;
    [scrollview addSubview:head1];
    head1BGView = [[UIView alloc]initWithFrame:CGRectMake(10, 95, SCREEN_WIDTH-20, 200)];
    head1BGView.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    LRViewBorderRadius(head1BGView, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:head1BGView];
    
    [self setupTextFieldOne];
    
    
    UILabel *head2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, SCREEN_WIDTH-20, 35)];
    head2.text = @"产品规格";
    head2.textAlignment = NSTextAlignmentCenter;
    [scrollview addSubview:head2];
    head2BGView = [[UIView alloc]initWithFrame:CGRectMake(10, 340, SCREEN_WIDTH-20, 260)];
    head2BGView.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    LRViewBorderRadius(head2BGView, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:head2BGView];
    
    [self setupTextFieldTwo];
    
    
    self.photosView = [[MKMessagePhotoView alloc]initWithFrame:CGRectMake(10,620,SCREEN_WIDTH-20, 80)];
    [scrollview addSubview:self.photosView];
    self.photosView.delegate = self;
    
    LRViewBorderRadius(head1BGView, 5, .2, UIColor.lightGrayColor);
    LRViewBorderRadius(head2BGView, 5, .2, UIColor.lightGrayColor);

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 730, SCREEN_WIDTH-20, 40);
    btn1.backgroundColor = baseColor;
    [btn1 setTitle:@"下一步[发布交易]" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickFaBu) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn1];
    
    scrollview.contentSize = CGSizeMake(0, 850);
}




- (void)setupTextFieldOne{
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 40)];
    lab1.textColor = [UIColor redColor];
    lab1.text = @"地理位置";
    [head1BGView addSubview:lab1];
    
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(90, 20, SCREEN_WIDTH-120, 40)];
    text2.delegate = self;
    text2.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text2.borderStyle = UITextBorderStyleNone;
    [head1BGView addSubview:text2];
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, SCREEN_WIDTH-120, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [head1BGView addSubview:line1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 80, 40)];
    lab2.textColor = [UIColor redColor];
    lab2.text = @"交易单位";
    [head1BGView addSubview:lab2];
    
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(90, 80, SCREEN_WIDTH-120, 40)];
    text3.delegate = self;
    text3.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text3.borderStyle = UITextBorderStyleNone;
    [head1BGView addSubview:text3];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 120, SCREEN_WIDTH-120, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [head1BGView addSubview:line2];
    
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, 80, 40)];
    lab3.textColor = [UIColor redColor];
    lab3.text = @"退货条件";
    [head1BGView addSubview:lab3];
    
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(90, 140, SCREEN_WIDTH-120, 40)];
    text4.delegate = self;
    text4.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text4.borderStyle = UITextBorderStyleNone;
    [head1BGView addSubview:text4];
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(90, 180, SCREEN_WIDTH-120, 1)];
    line3.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [head1BGView addSubview:line3];
}



- (void)setupTextFieldTwo{
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 40)];
    lab1.text = @"品牌";
    [head2BGView addSubview:lab1];
    
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(90, 20, SCREEN_WIDTH-120, 40)];
    text5.delegate = self;
    text5.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text5.borderStyle = UITextBorderStyleNone;
    [head2BGView addSubview:text5];
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, SCREEN_WIDTH-120, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [head2BGView addSubview:line1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 80, 40)];
    lab2.text = @"生产日期";
    [head2BGView addSubview:lab2];
    
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(90, 80, SCREEN_WIDTH-120, 40)];
    text6.delegate = self;
    text6.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text6.borderStyle = UITextBorderStyleNone;
    [head2BGView addSubview:text6];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 120, SCREEN_WIDTH-120, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [head2BGView addSubview:line2];
    
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, 80, 40)];
    lab3.text = @"保质期";
    [head2BGView addSubview:lab3];
    
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(90, 140, SCREEN_WIDTH-120, 40)];
    text7.delegate = self;
    text7.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text7.borderStyle = UITextBorderStyleNone;
    [head2BGView addSubview:text7];
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(90, 180, SCREEN_WIDTH-120, 1)];
    line3.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [head2BGView addSubview:line3];
    
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 80, 40)];
    lab4.text = @"型号规格";
    [head2BGView addSubview:lab4];
    
    text8 = [[UITextField alloc]initWithFrame:CGRectMake(90, 200, SCREEN_WIDTH-120, 40)];
    text8.delegate = self;
    text8.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    text8.borderStyle = UITextBorderStyleNone;
    [head2BGView addSubview:text8];
    
    UILabel *line4 = [[UILabel alloc]initWithFrame:CGRectMake(90, 240, SCREEN_WIDTH-120, 1)];
    line4.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [head2BGView addSubview:line4];
}





@end
