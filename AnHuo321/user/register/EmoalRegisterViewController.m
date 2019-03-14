//
//  EmoalRegisterViewController.m
//  AnHuo
//
//  Created by 吕书涛 on 2019/1/28.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "EmoalRegisterViewController.h"

@interface EmoalRegisterViewController ()<UITextFieldDelegate>
{
    UIScrollView *scrollview;
    UITextField *text0;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    
    UIButton *sendYZNBtn;
    
    SQCustomButton *a_btn;
    SQCustomButton *b_btn;
    SQCustomButton *c_btn;
    BOOL isnoA;
    BOOL isnoB;
    BOOL isnoC;
    
    NSString *str;
}

@end

@implementation EmoalRegisterViewController

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
    NSDictionary *dic = @{@"email":text0.text,
                          @"email_verify":text1.text,
                          @"nickname":text2.text,
                          @"truename":text3.text,
                          @"mobile":text4.text,
                          @"pwd":text5.text,
                          @"pwded":text6.text,
                          @"feedback":str,
                          @"registerType":@"email",
                          };
    [Manager post:KURLNSString(@"Login/register") RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        NSLog(@"%@-------%@",dict,[dict objectForKey:@"info"]);
        if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]]isEqualToString:@"1"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[dict objectForKey:@"info"]];
        }
        [SVProgressHUD dismissWithDelay:1];
    }];
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        if ([XYQRegexPatternHelper validateEmail:text1.text] != YES){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的邮箱号" message:@"温馨提示" preferredStyle:1];
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








- (void)clicksendYZM{
    if ([XYQRegexPatternHelper validateEmail:text1.text] != YES) {
        [self getYZM];
        __block int timeout=59; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                    [self->sendYZNBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                    //设置不可点击
                    self->sendYZNBtn.userInteractionEnabled = YES;
                    self->sendYZNBtn.backgroundColor = [UIColor redColor];
                });
            }else{
                // int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [self->sendYZNBtn setTitle:[NSString stringWithFormat:@"%@s重新发送",strTime] forState:UIControlStateNormal];
                    //设置可点击
                    self->sendYZNBtn.userInteractionEnabled = NO;
                    self->sendYZNBtn.backgroundColor = [UIColor lightGrayColor];
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的邮箱号" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //            [self->text1 becomeFirstResponder];
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)getYZM{
    //    LRWeakSelf(self);
    NSDictionary *dic = @{@"checkadr":text0.text,
                          @"checktp":@"email",
                          @"how":@"register",
                          };
    //NSLog(@"--%@",dic);
    [Manager post:KURLNSString(@"Login/sendCode") RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        //NSLog(@"邮箱验证码-------%@-------%@",dict,[dict objectForKey:@"info"]);
    }];
    
}





















- (void)setupview{
    text0 = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 50)];
    text0.placeholder = @"邮箱";
    text0.borderStyle = UITextBorderStyleRoundedRect;
    text0.clearButtonMode = UITextFieldViewModeWhileEditing;
    text0.keyboardType = UIKeyboardTypeEmailAddress;
    [scrollview addSubview:text0];
    
    
    sendYZNBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendYZNBtn.frame = CGRectMake(SCREEN_WIDTH-130, 70, 120, 50);
    sendYZNBtn.backgroundColor = RGBACOLOR(190, 8, 7, 1);
    [sendYZNBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendYZNBtn addTarget:self action:@selector(clicksendYZM) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(sendYZNBtn, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:sendYZNBtn];
    
    
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH-145, 50)];
    text1.placeholder = @"邮箱验证码";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollview addSubview:text1];
    
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20, 50)];
    text2.placeholder = @"昵称";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollview addSubview:text2];
    
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 190, SCREEN_WIDTH-20, 50)];
    text3.placeholder = @"真实姓名";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollview addSubview:text3];
    
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH-20, 50)];
    text4.placeholder = @"手机号";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.clearButtonMode = UITextFieldViewModeWhileEditing;
    text4.keyboardType = UIKeyboardTypePhonePad;
    [scrollview addSubview:text4];
    
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 50)];
    text5.placeholder = @"登录密码";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.clearButtonMode = UITextFieldViewModeWhileEditing;
    text5.secureTextEntry = YES;
    [scrollview addSubview:text5];
    
    
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10, 370, SCREEN_WIDTH-20, 50)];
    text6.placeholder = @"确认密码";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    text6.clearButtonMode = UITextFieldViewModeWhileEditing;
    text6.secureTextEntry = YES;
    [scrollview addSubview:text6];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 430, SCREEN_WIDTH-20, 30)];
    lab.text = @"您是通过什么途径了解到321安货的?";
    [scrollview addSubview:lab];
    
    a_btn = [[SQCustomButton alloc]initWithFrame:CGRectMake(20, 470, 80, 40)
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
    
    b_btn = [[SQCustomButton alloc]initWithFrame:CGRectMake(20, 510, 80, 40)
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
    
    c_btn = [[SQCustomButton alloc]initWithFrame:CGRectMake(20, 550, 48, 40)
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
    registerBtn.frame = CGRectMake(10, 620, SCREEN_WIDTH-20, 50);
    registerBtn.backgroundColor = RGBACOLOR(190, 8, 7, 1);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(clickregister) forControlEvents:UIControlEventTouchUpInside];
    LRViewBorderRadius(registerBtn, 5, 0, [UIColor clearColor]);
    [scrollview addSubview:registerBtn];
    
    scrollview.contentSize = CGSizeMake(0, 720);
    
}


@end
