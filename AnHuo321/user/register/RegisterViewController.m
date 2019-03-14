//
//  RegisterViewController.m
//  AnHuo
//
//  Created by 吕书涛 on 2019/1/28.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZhanghaoRegisterViewController.h"
#import "PhoneRegisterViewController.h"
#import "EmoalRegisterViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    ZhanghaoRegisterViewController *vc1 = [[ZhanghaoRegisterViewController alloc] init];
    vc1.title = @"账号注册";
    
    PhoneRegisterViewController *vc2 = [[PhoneRegisterViewController alloc] init];
    vc2.title = @"手机注册";
    
    EmoalRegisterViewController *vc3 = [[EmoalRegisterViewController alloc] init];
    vc3.title = @"邮箱注册";
    
    self.viewControllers = @[vc1, vc2, vc3];
    // Do any additional setup after loading the view.
}



/*
 #pragma mark - Navigation     GetPasswordViewController
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
