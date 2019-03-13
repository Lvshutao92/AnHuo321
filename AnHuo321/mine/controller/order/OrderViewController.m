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
    UIView *bgview3;
}
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupview];
    // Do any additional setup after loading the view.
}

- (void)setupview{
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:scrollview];
    
    bgview1 = [[UIView alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 200)];
    bgview1.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    LRViewBorderRadius(bgview1, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:bgview1];
    UILabel *head1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    head1.text = @"我买到的";
    head1.textColor = [UIColor redColor];
    [bgview1 addSubview:head1];
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH-20, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [bgview1 addSubview:line1];
    
    
    [self setButtonOne];
    
    
    bgview2 = [[UIView alloc]initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 200)];
    bgview2.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    LRViewBorderRadius(bgview2, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:bgview2];
    UILabel *head2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    head2.text = @"我卖出的";
    head2.textColor = [UIColor redColor];
    [bgview2 addSubview:head2];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH-20, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [bgview2 addSubview:line2];
    
    
    [self setButtonTwo];
    
    bgview3 = [[UIView alloc]initWithFrame:CGRectMake(10, 460, SCREEN_WIDTH-20, 200)];
    bgview3.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    LRViewBorderRadius(bgview3, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:bgview3];
    UILabel *head3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    head3.text = @"退货信息";
    head3.textColor = [UIColor redColor];
    [bgview3 addSubview:head3];
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH-20, 1)];
    line3.backgroundColor = [UIColor colorWithWhite:.6 alpha:.2];
    [bgview3 addSubview:line3];
    
    [self setButtonThree];
    
    
    scrollview.contentSize = CGSizeMake(0, 700);
}


- (void)setButtonOne{
    NSMutableArray *arr1 = [@[@"待付款",@"待发货",@"待收货",@"交易成功",@"已评价",@"已互评"]mutableCopy];
    NSMutableArray *arr2 = [@[@"a1",@"a2",@"a3",@"a4",@"a1",@"a2"]mutableCopy];
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
                btn.frame = CGRectMake((0  + j * (SCREEN_WIDTH-20)/5), 50+(i * 75) ,(SCREEN_WIDTH-20)/5, 75);
                btn.tag = b;
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickBtnOne:) forControlEvents:UIControlEventTouchUpInside];
                //                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                //                [btn.layer setBorderWidth:0.5f];
                //                [btn.layer setMasksToBounds:YES];
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
    NSMutableArray *arr1 = [@[@"待付款",@"待发货",@"待收货",@"交易成功",@"已评价",@"已互评"]mutableCopy];
    NSMutableArray *arr2 = [@[@"a1",@"a2",@"a3",@"a4",@"a1",@"a2"]mutableCopy];
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
                btn.frame = CGRectMake((0  + j * (SCREEN_WIDTH-20)/5), 50+(i * 75) ,(SCREEN_WIDTH-20)/5, 75);
                btn.tag = b;
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickBtnTwo:) forControlEvents:UIControlEventTouchUpInside];
                //                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                //                [btn.layer setBorderWidth:0.5f];
                //                [btn.layer setMasksToBounds:YES];
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



- (void)setButtonThree{
    NSMutableArray *arr1 = [@[@"待付款",@"待发货",@"待收货",@"交易成功",@"已评价",@"已互评"]mutableCopy];
    NSMutableArray *arr2 = [@[@"a1",@"a2",@"a3",@"a4",@"a1",@"a2"]mutableCopy];
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
                btn.frame = CGRectMake((0  + j * (SCREEN_WIDTH-20)/5), 50+(i * 75) ,(SCREEN_WIDTH-20)/5, 75);
                btn.tag = b;
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickBtnThree:) forControlEvents:UIControlEventTouchUpInside];
                //                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                //                [btn.layer setBorderWidth:0.5f];
                //                [btn.layer setMasksToBounds:YES];
                [bgview3 addSubview:btn];
                if (b > arr1.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}
- (void)clickBtnThree:(UIButton *)sender{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
