//
//  LoginViewController.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/14.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "GetPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIImageView *bgimg;
    UITextField *text1;
    UITextField *text2;
    
    UIButton *btn;
    UIButton *wjmmBtn;
    UIButton *zcBtn;
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    [self setupview];
}


- (void)clickRegister{
    RegisterViewController *regis = [[RegisterViewController alloc]init];
    regis.title = @"欢迎注册321安货";
    [self.navigationController pushViewController:regis animated:YES];

}
- (void)clickWjmm{
    GetPasswordViewController *regis = [[GetPasswordViewController alloc]init];
    regis.title = @"找回密码";
    [self.navigationController pushViewController:regis animated:YES];
}









- (void)clickLogin{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    
    LRWeakSelf(self);
    NSDictionary *dic = @{@"account":text1.text,
                          @"pwd":text2.text,
                          };
    [Manager post:KURLNSString(@"Login/loginForApp") RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dict = [Manager returndictiondata:data];
            
            if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]]isEqualToString:@"1"]) {
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                
                [GlobleStting setUsername:self->text1.text];
                [GlobleStting setPassword:self->text2.text];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:[dict objectForKey:@"info"]];
            }
            [SVProgressHUD dismissWithDelay:1];
        });
        
    }];
    
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([textField isEqual:text2]){
        if ([XYQRegexPatternHelper validatePassword:text2.text] != YES){
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
//    bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-260, 200, 100)];
//    bgimg.image = [UIImage imageNamed:@"321"];
//    bgimg.userInteractionEnabled = YES;
//    [self.view addSubview:bgimg];
    
    
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, kNavBarHAbove7+55, 30, 30)];
    img1.image = [UIImage imageNamed:@"手机"];
    [self.view addSubview:img1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(65, kNavBarHAbove7+50, SCREEN_WIDTH-95, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入账号";
    //    text1.keyboardType = UIKeyboardTypeNumberPad;
    text1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:text1];
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, kNavBarHAbove7+90, SCREEN_WIDTH-60, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.5 alpha:1];
    [self.view addSubview:line1];
    
    
    
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(30, kNavBarHAbove7 +115, 30, 30)];
    img2.image = [UIImage imageNamed:@"密码"];
    [self.view addSubview:img2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(65, kNavBarHAbove7+110, SCREEN_WIDTH-95, 40)];
    text2.delegate = self;
    text2.placeholder = @"请输入密码";
    text2.secureTextEntry = YES;
    text2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:text2];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(30, kNavBarHAbove7+150, SCREEN_WIDTH-60, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:.5 alpha:1];
    [self.view addSubview:line2];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, kNavBarHAbove7+180, SCREEN_WIDTH-60, 50);
    btn.backgroundColor = baseColor;
    LRViewBorderRadius(btn, 8, 0, [UIColor clearColor]);
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
    
    zcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zcBtn.frame = CGRectMake(30, kNavBarHAbove7+240, 100, 40);
    [zcBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    zcBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zcBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [zcBtn addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zcBtn];
    
    wjmmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wjmmBtn.frame = CGRectMake(SCREEN_WIDTH-130, kNavBarHAbove7+240, 100, 40);
    [wjmmBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    wjmmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [wjmmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [wjmmBtn addTarget:self action:@selector(clickWjmm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wjmmBtn];
    
    
    text1.keyboardAppearance = UIKeyboardAppearanceLight;
    text2.keyboardAppearance = UIKeyboardAppearanceLight;
    
    
    text1.textColor = baseColor;
    text2.textColor = baseColor;
    
    btn.backgroundColor = baseColor;
    [zcBtn setTitleColor:baseColor forState:UIControlStateNormal];
    [wjmmBtn setTitleColor:baseColor forState:UIControlStateNormal];
    
    
  
}


@end
