//
//  GetPasswordViewController.m
//  AnHuo
//
//  Created by 吕书涛 on 2019/1/28.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "GetPasswordViewController.h"
#import "PhoneGetPasswordViewController.h"
#import "EmailGetPasswordViewController.h"

@interface GetPasswordViewController ()

@end

@implementation GetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    PhoneGetPasswordViewController *vc2 = [[PhoneGetPasswordViewController alloc] init];
    vc2.title = @"用手机找回";
    
    EmailGetPasswordViewController *vc3 = [[EmailGetPasswordViewController alloc] init];
    vc3.title = @"用邮箱找回";
    
    self.viewControllers = @[vc2, vc3];
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
