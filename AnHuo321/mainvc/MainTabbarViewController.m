//
//  MainTabbarViewController.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/13.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "HomeViewController.h"
#import "IssueViewController.h"
#import "MineViewController.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (instancetype)init {
    if (self = [super init]) {
        HomeViewController *oneVc = [[HomeViewController alloc]init];
        MainNavigationViewController *aaa = [[MainNavigationViewController alloc]initWithRootViewController:oneVc];
        aaa.tabBarItem.image = [UIImage imageNamed:@"1"];
        aaa.title = @"首页";
        oneVc.navigationItem.title = @"321安货";
        aaa.tabBarItem.selectedImage = [UIImage imageNamed:@"01"];
        
        
        
        IssueViewController *twoVc = [[IssueViewController alloc]init];
        MainNavigationViewController *bbb = [[MainNavigationViewController alloc]initWithRootViewController:twoVc];
        bbb.tabBarItem.image = [UIImage imageNamed:@"2"];
        twoVc.title = @"发布";
        bbb.tabBarItem.selectedImage = [UIImage imageNamed:@"02"];
        
        
        MineViewController *thrVc = [[MineViewController alloc]init];
        MainNavigationViewController *ccc = [[MainNavigationViewController alloc]initWithRootViewController:thrVc];
        ccc.tabBarItem.image = [UIImage imageNamed:@"3"];
        thrVc.title = @"我的";
        ccc.tabBarItem.selectedImage = [UIImage imageNamed:@"03"];
        
        
        self.tabBar.tintColor = baseColor;
        self.viewControllers = @[aaa,bbb,ccc];
    }
    return self;
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
