//
//  AddrViewController.m
//  英德格斯
//
//  Created by 吕书涛 on 2018/11/13.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "AddrViewController.h"
#import "ADD_Address_ViewController.h"

@interface AddrViewController ()

@end

@implementation AddrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    btn.backgroundColor = baseColor;
    [btn setTitle:@"+收货地址" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)clickAdd{
    ADD_Address_ViewController *add = [[ADD_Address_ViewController alloc]init];
    add.title = @"新增";
    [self.navigationController pushViewController:add animated:YES];
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
