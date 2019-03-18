//
//  SecondViewTableViewController.h
//  DemoTest
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SecondViewTableViewController.h"
#import "ChuRuCell.h"

@interface SecondViewTableViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *footerView;
    
    UITextField *text1;
    UITextField *text2;
}
@property(nonatomic ,strong)UITableView * myTableView;

@end

@implementation SecondViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"7467456745674567========+");

    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-64-44)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    [_myTableView registerNib:[UINib nibWithNibName:@"ChuRuCell" bundle:nil] forCellReuseIdentifier:@"cell"];

//    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerView.backgroundColor = [UIColor colorWithWhite:.8 alpha:.25];
    _myTableView.tableHeaderView = headerView;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
    lab.text = @"报价人";
    [headerView addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 80, 50)];
    lab1.text = @"单价";
    [headerView addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(190, 0, 80, 50)];
    lab2.text = @"数量";
    [headerView addSubview:lab2];
    
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _myTableView.tableFooterView = footerView;
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    v.backgroundColor = RGBACOLOR(255, 192, 203, 1);
    [footerView addSubview:v];
    
    UILabel *danjia = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 30)];
    danjia.textAlignment = NSTextAlignmentCenter;
    danjia.text = @"单价";
    danjia.textColor = UIColor.redColor;
    [v addSubview:danjia];
    
    UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 30)];
    num.textAlignment = NSTextAlignmentCenter;
    num.text = @"数量";
    num.textColor = UIColor.redColor;
    [v addSubview:num];
    
    text1 = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-120)/2, 40, 120, 40)];
    text1.delegate = self;
    text1.textAlignment = NSTextAlignmentCenter;
    text1.borderStyle = UITextBorderStyleLine;
    [footerView addSubview:text1];
    
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+(SCREEN_WIDTH/2-120)/2, 40, 120, 40)];
    text2.delegate = self;
    text2.textAlignment = NSTextAlignmentCenter;
    text2.borderStyle = UITextBorderStyleLine;
    [footerView addSubview:text2];
}


#pragma mark --tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    ChuRuCell  * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ChuRuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.lab1.text = @"吕大哥9999999";
    cell.lab2.text = @"5888885";
    cell.lab3.text = @"9994";

    return cell;
}

@end
