//
//  DetailsViewController.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/16.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import "DetailsViewController.h"
#import "HomeModel.h"
@interface DetailsViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    UIImageView *userIMG;
    
}

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *bgv;

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headerView;
    [self.headerView addSubview:self.cycleScrollView];
    
}
- (void)lodDtata{
    LRWeakSelf(self);
    NSDictionary *dic = @{@"pid":self.idString,
                          };
    [Manager post:KURLNSString(productDetails) RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        NSDictionary *dictions = [[dict objectForKey:@"data"] firstObject];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
        [array removeAllObjects];
        for (NSDictionary *dicc in [dictions objectForKey:@"imgSrc"]) {
            HomeModel *model = [HomeModel mj_objectWithKeyValues:dicc];
            [array addObject:model.img];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.cycleScrollView.imageURLStringsGroup = array;
            //self->lab1.text = [NSString stringWithFormat:@"发布人：%@",[dictions objectForKey:@"seller"]];
        });
        //NSLog(@"---------%@",dict);
    }];
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        
    }
    return _cycleScrollView;
}
//轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}













- (UIView *)bgv{
    if (_bgv==nil) {
        _bgv = [AHControll viewWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 100) viewColor:[UIColor colorWithWhite:.8 alpha:.3]];
    }
    return _bgv;
}
- (UIView *)headerView{
    if (_headerView==nil) {
        self.headerView = [AHControll viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500) viewColor:UIColor.whiteColor];
    }
    return _headerView;
}
- (UITableView *)tableview{
    if (_tableview==nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}
- (NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
