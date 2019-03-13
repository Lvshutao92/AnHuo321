//
//  MineViewController.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/13.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import "MineViewController.h"
#import "PersonCell.h"
#import "MyGuanZhuViewController.h"
#import "OrderViewController.h"
#import "AddrViewController.h"
#import "InformationViewController.h"
#import "SetViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIImageView *userImg;
    UILabel *userName;

}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headerView;
    // Do any additional setup after loading the view.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            MyGuanZhuViewController *vc = [[MyGuanZhuViewController alloc]init];
            vc.title = @"关注";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1) {
            OrderViewController *vc = [[OrderViewController alloc]init];
            vc.title = @"我的订单";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2) {
            AddrViewController *vc = [[AddrViewController alloc]init];
            vc.title = @"收货地址";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            InformationViewController *vc = [[InformationViewController alloc]init];
            vc.title = @"通知";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        SetViewController *vc = [[SetViewController alloc]init];
        vc.title = @"设置";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.lab.text = @"我的关注";
                cell.img.image = [UIImage imageNamed:@"0000"];
            }
                break;
            case 1:
            {
                cell.lab.text = @"我的订单";
                cell.img.image = [UIImage imageNamed:@"0001"];
            }
                break;
            case 2:
            {
                cell.lab.text = @"收货地址";
                cell.img.image = [UIImage imageNamed:@"0002"];
            }
                break;
            case 3:
            {
                cell.lab.text = @"消息提醒";
                cell.img.image = [UIImage imageNamed:@"0003"];
            }
                break;
            default:
                break;
        }
    }else{
        cell.lab.text = @"系统设置";
        cell.img.image = [UIImage imageNamed:@"0004"];
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UITableView *)tableview{
    if (_tableview==nil) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        [self.tableview registerNib:[UINib nibWithNibName:@"PersonCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:self.tableview];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, .0001)];
        
    }
    return _tableview;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = W_CA(.8, .3);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)headerView{
    if (_headerView == nil) {
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _headerView;
}

@end
