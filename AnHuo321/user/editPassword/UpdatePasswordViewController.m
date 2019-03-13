//
//  UpdatePasswordViewController.m
//  英德格斯
//
//  Created by 吕书涛 on 2018/11/13.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "UpdatePasswordViewController.h"

@interface UpdatePasswordViewController ()<UITextFieldDelegate>
{
    UITextField *textf1;
    UITextField *textf2;
    UITextField *textf3;
}
@end

@implementation UpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    textf1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 10+kNavBarHAbove7, SCREEN_WIDTH-20, 50)];
    textf1.delegate = self;
    textf1.placeholder = @"旧密码";
    [self.view addSubview:textf1];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 60+kNavBarHAbove7, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    [self.view addSubview:line];
    
    
    
    
    textf2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 70+kNavBarHAbove7, SCREEN_WIDTH-20, 50)];
    textf2.delegate = self;
    textf2.placeholder = @"新密码";
    [self.view addSubview:textf2];
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 120+kNavBarHAbove7, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    [self.view addSubview:line1];
    
    
    textf3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 130+kNavBarHAbove7, SCREEN_WIDTH-20, 50)];
    textf3.delegate = self;
    textf3.placeholder = @"再次确认新密码";
    [self.view addSubview:textf3];
    UILabel *line11 = [[UILabel alloc]initWithFrame:CGRectMake(0, 180+kNavBarHAbove7, SCREEN_WIDTH, 1)];
    line11.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    [self.view addSubview:line11];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, kNavBarHAbove7+210, SCREEN_WIDTH-20, 50);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    LRViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
    btn.backgroundColor =RGBACOLOR(190, 8, 7, 1);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
}
- (void)commit{
    [textf1 resignFirstResponder];
    [textf2 resignFirstResponder];
    [textf3 resignFirstResponder];

    if (textf1.text.length > 0 && textf2.text.length >0 && textf3.text.length>0) {
        if ([textf2.text isEqualToString:textf3.text]) {
            
            LRWeakSelf(self);
            NSDictionary *dic = @{@"pwd":textf1.text,
                                  @"newPwd":textf2.text,
                                  @"confirmPwd":textf3.text,
                                  };
            [Manager post:KURLNSString(@"Appapi/resetPassword") RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *dict = [Manager returndictiondata:data];
                    if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"result"]]isEqualToString:@"1"]) {
                        
                        [Manager writewenjianming:@"password" content:self->textf2.text];
                        
                        [SVProgressHUD showSuccessWithStatus:@"修改成功，再次登录生效"];
                    }else{
                        [SVProgressHUD showErrorWithStatus:[dict objectForKey:@"info"]];
                    }
                });
            }];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新密码输入不相同，请重新输入" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}






- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([textField isEqual:textf1]) {
        if (![[Manager redingwenjianming:@"password"]isEqualToString:textf1.text]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您输入的旧密码错误" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if ([textField isEqual:textf2]){
        if ([XYQRegexPatternHelper validatePassword:textf2.text] != YES){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码由6-20位数字或字母组成" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if ([textField isEqual:textf3]){
        if ([XYQRegexPatternHelper validatePassword:textf3.text] != YES){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码由6-20位数字或字母组成" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    return YES;
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
