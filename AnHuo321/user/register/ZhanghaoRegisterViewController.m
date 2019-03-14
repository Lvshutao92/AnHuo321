//
//  ZhanghaoRegisterViewController.m
//  AnHuo
//
//  Created by 吕书涛 on 2019/1/28.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ZhanghaoRegisterViewController.h"

@interface ZhanghaoRegisterViewController ()<UITextFieldDelegate>
{
    NSString *str;
    
    UIScrollView *scrollview;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    
    SQCustomButton *a_btn;
    SQCustomButton *b_btn;
    SQCustomButton *c_btn;
    
    BOOL isnoA;
    BOOL isnoB;
    BOOL isnoC;
}
@end

@implementation ZhanghaoRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.4];
    [self.view addSubview:scrollview];
    
    
    [self setupview];
    // Do any additional setup after loading the view.
}


- (void)clickregister{
    LRWeakSelf(self);
    NSDictionary *dic = @{@"account":text1.text,
                          @"nickname":text2.text,
                          @"truename":text3.text,
                          @"mobile":text4.text,
                          @"pwd":text5.text,
                          @"pwded":text6.text,
                          @"feedback":str,
                          @"registerType":@"account",
                          };
    [Manager post:KURLNSString(@"Login/register") RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]]isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[dict objectForKey:@"info"]];
        }
        [SVProgressHUD dismissWithDelay:1];
        //NSLog(@"%@-------%@",dict,[dict objectForKey:@"info"]);
    }];
    
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([textField isEqual:text4]) {
        if ([XYQRegexPatternHelper validateMobile:text4.text] != YES){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if ([textField isEqual:text1]){
        if ([XYQRegexPatternHelper validateUserName:text1.text] != YES){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户名以字母开头，5-17位字母、数字或者_组成" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if ([textField isEqual:text5]){
        if ([XYQRegexPatternHelper validatePassword:text5.text] != YES){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码由6-20位数字或字母组成" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if ([textField isEqual:text6]){
        if ([XYQRegexPatternHelper validatePassword:text6.text] != YES){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码由6-20位数字或字母组成" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    return YES;
}




- (void)setupview{
    
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 50)];
    text1.placeholder = @"账号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollview addSubview:text1];
    
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH-20, 50)];
    text2.placeholder = @"昵称";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollview addSubview:text2];
    
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20, 50)];
    text3.placeholder = @"真实姓名";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollview addSubview:text3];
    
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 190, SCREEN_WIDTH-20, 50)];
    text4.placeholder = @"手机号";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.clearButtonMode = UITextFieldViewModeWhileEditing;
    text4.keyboardType = UIKeyboardTypePhonePad;
    [scrollview addSubview:text4];
    
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH-20, 50)];
    text5.placeholder = @"登录密码";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.clearButtonMode = UITextFieldViewModeWhileEditing;
    text5.secureTextEntry = YES;
    [scrollview addSubview:text5];
    
    
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 50)];
    text6.placeholder = @"确认密码";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    text6.clearButtonMode = UITextFieldViewModeWhileEditing;
    text6.secureTextEntry = YES;
    [scrollview addSubview:text6];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 370, SCREEN_WIDTH-20, 30)];
    lab.text = @"您是通过什么途径了解到321安货的?";
    [scrollview addSubview:lab];
    
    a_btn = [[SQCustomButton alloc]initWithFrame:CGRectMake(20, 410, 80, 40)
                                            type:SQCustomButtonLeftImageType
                                       imageSize:CGSizeMake(20, 20) midmargin:10];
    a_btn.isShowSelectBackgroudColor = NO;
    a_btn.imageView.image = [UIImage imageNamed:@"noselected"];
    a_btn.titleLabel.text = @"网络推广";
    a_btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:a_btn];
    [a_btn touchAction:^(SQCustomButton * _Nonnull button) {
        button.imageView.image = [UIImage imageNamed:@"isselected"];
        self->b_btn.imageView.image = [UIImage imageNamed:@"noselected"];
        self->c_btn.imageView.image = [UIImage imageNamed:@"noselected"];
        self->str = @"1";
    }];
    
    b_btn = [[SQCustomButton alloc]initWithFrame:CGRectMake(20, 460, 80, 40)
                                            type:SQCustomButtonLeftImageType
                                       imageSize:CGSizeMake(20, 20) midmargin:10];
    b_btn.isShowSelectBackgroudColor = NO;
    b_btn.imageView.image = [UIImage imageNamed:@"noselected"];
    b_btn.titleLabel.text = @"朋友介绍";
    b_btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:b_btn];
    [b_btn touchAction:^(SQCustomButton * _Nonnull button) {
        button.imageView.image = [UIImage imageNamed:@"isselected"];
        self->a_btn.imageView.image = [UIImage imageNamed:@"noselected"];
        self->c_btn.imageView.image = [UIImage imageNamed:@"noselected"];
        self->str = @"4";
    }];
    
    c_btn = [[SQCustomButton alloc]initWithFrame:CGRectMake(20, 510, 48, 40)
                                            type:SQCustomButtonLeftImageType
                                       imageSize:CGSizeMake(20, 20) midmargin:10];
    c_btn.isShowSelectBackgroudColor = NO;
    c_btn.imageView.image = [UIImage imageNamed:@"noselected"];
    c_btn.titleLabel.text = @"其他";
    c_btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:c_btn];
    [c_btn touchAction:^(SQCustomButton * _Nonnull button) {
        button.imageView.image = [UIImage imageNamed:@"isselected"];
        self->a_btn.imageView.image = [UIImage imageNamed:@"noselected"];
        self->b_btn.imageView.image = [UIImage imageNamed:@"noselected"];
        self->str = @"5";
    }];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(10, 580, SCREEN_WIDTH-20, 50);
    registerBtn.backgroundColor = RGBACOLOR(190, 8, 7, 1);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(clickregister) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(registerBtn, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:registerBtn];
    
    scrollview.contentSize = CGSizeMake(0, 700);
    text1.delegate = self;
    text2.delegate = self;
    text3.delegate = self;
    text4.delegate = self;
    text5.delegate = self;
    text6.delegate = self;
}


@end
