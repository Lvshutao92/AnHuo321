//
//  OrderViewController.m
//  英德格斯
//
//  Created by ilovedxracer on 2018/12/25.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()
{

    UIScrollView *scrollview;
    UIView *bgview1;
    UIView *bgview2;
}
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupview];
}

- (void)setupview{
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollview.backgroundColor = W_CA(.8, .3);
    [self.view addSubview:scrollview];
    //买家
    bgview1 = [AHControll viewWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 210) viewColor:UIColor.whiteColor];
    LRViewBorderRadius(bgview1, 10, 0, UIColor.clearColor);
    [scrollview addSubview:bgview1];
    UIView *vLine1 = [AHControll viewWithFrame:CGRectMake(0, 39, SCREEN_WIDTH-20, 1) viewColor:W_CA(.8, .3)];
    [bgview1 addSubview:vLine1];
    UILabel *lab1 = [AHControll createLabelWithFrame:CGRectMake(10, 10, 100, 20) Font:16 Text:@"我是买家" textColor:UIColor.blackColor NSTextAlignment:NSTextAlignmentLeft];
    [bgview1 addSubview:lab1];
    UIButton *moreBtn1 = [AHControll createButtonNormalFrame:CGRectMake(SCREEN_WIDTH-100, 10, 80, 20) Target:self Action:@selector(clickMoreOne) Title:@"查看更多" TitleColor:UIColor.darkGrayColor Font:14 BackGColor:UIColor.whiteColor];
    [bgview1 addSubview:moreBtn1];
    
    
    //卖家
    bgview2 = [AHControll viewWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 210) viewColor:UIColor.whiteColor];
    LRViewBorderRadius(bgview2, 10, 0, UIColor.clearColor);
    [scrollview addSubview:bgview2];
    UIView *vLine2 = [AHControll viewWithFrame:CGRectMake(0, 39, SCREEN_WIDTH-20, 1) viewColor:W_CA(.8, .3)];
    [bgview2 addSubview:vLine2];
    UILabel *lab2 = [AHControll createLabelWithFrame:CGRectMake(10, 10, 100, 20) Font:16 Text:@"我是卖家" textColor:UIColor.blackColor NSTextAlignment:NSTextAlignmentLeft];
    [bgview2 addSubview:lab2];
    UIButton *moreBtn2 = [AHControll createButtonNormalFrame:CGRectMake(SCREEN_WIDTH-100, 10, 80, 20) Target:self Action:@selector(clickMoreTwo) Title:@"查看更多" TitleColor:UIColor.darkGrayColor Font:14 BackGColor:UIColor.whiteColor];
    [bgview2 addSubview:moreBtn2];
    
    [self setButtonOne];
    [self setButtonTwo];
    
    
    UIView *bg1 = [AHControll viewWithFrame:CGRectMake(10, 140, SCREEN_WIDTH-40, 60) viewColor:W_CA(.8, .3)];
    LRViewBorderRadius(bg1, 5, 0, UIColor.clearColor);
    [bgview1 addSubview:bg1];
    
    UIView *bg2 = [AHControll viewWithFrame:CGRectMake(10, 140, SCREEN_WIDTH-40, 60) viewColor:W_CA(.8, .3)];
    LRViewBorderRadius(bg2, 5, 0, UIColor.clearColor);
    [bgview2 addSubview:bg2];
    
    scrollview.contentSize = CGSizeMake(0, 700);
}
- (void)clickMoreOne{
    
    
}
- (void)clickMoreTwo{
    
    
}
- (void)setButtonOne{
    NSMutableArray *arr1 = [@[@"待付款",@"待发货",@"待收货",@"评价",@"退货/售后"]mutableCopy];
    NSMutableArray *arr2 = [@[@"a1",@"a2",@"a3",@"a4",@"a1"]mutableCopy];
    int b = 0;
    int hangshu;
    if (arr1.count % 5 == 0 ) {
        hangshu = (int )arr1.count / 5;
    } else {
        hangshu = (int )arr1.count / 5 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 5; j++) {
            CustomBtn *btn = [CustomBtn buttonWithType:UIButtonTypeCustom];
            if ( b  < arr1.count) {
                btn.frame = CGRectMake((0  + j * (SCREEN_WIDTH-20)/5), 40+(i * 100) ,(SCREEN_WIDTH-20)/5, 100);
                btn.tag = b;
                btn.titleLabel.font = FONT(14);
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickBtnOne:) forControlEvents:UIControlEventTouchUpInside];
                [bgview1 addSubview:btn];
                if (b > arr1.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}
- (void)clickBtnOne:(UIButton *)sender{
}



- (void)setButtonTwo{
    NSMutableArray *arr1 = [@[@"待付款",@"待发货",@"待收货",@"评价",@"退货/售后"]mutableCopy];
    NSMutableArray *arr2 = [@[@"a1",@"a2",@"a3",@"a4",@"a1"]mutableCopy];
    int b = 0;
    int hangshu;
    if (arr1.count % 5 == 0 ) {
        hangshu = (int )arr1.count / 5;
    } else {
        hangshu = (int )arr1.count / 5 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 5; j++) {
            CustomBtn *btn = [CustomBtn buttonWithType:UIButtonTypeCustom];
            if ( b  < arr1.count) {
                btn.frame = CGRectMake((0  + j * (SCREEN_WIDTH-20)/5), 40+(i * 100) ,(SCREEN_WIDTH-20)/5, 100);
                btn.tag = b;
                btn.titleLabel.font = FONT(14);
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickBtnTwo:) forControlEvents:UIControlEventTouchUpInside];
                [bgview2 addSubview:btn];
                if (b > arr1.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}
- (void)clickBtnTwo:(UIButton *)sender{
    
}



@end
