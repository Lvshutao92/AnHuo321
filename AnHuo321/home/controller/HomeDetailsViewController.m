//
//  HomeDetailsViewController.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/15.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "TestTableView.h"
#import "WMPageController.h"
#import "OneViewTableTableViewController.h"
#import "SecondViewTableViewController.h"
#import "ChuRuCell.h"
#import "HomeModel.h"
#import "DetailsThreeViewController.h"

static CGFloat const headViewHeight = 485;


@interface HomeDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,WMPageControllerDelegate,SDCycleScrollViewDelegate>
{
    UIView *topview1;
    UIView *topview2;
    UIButton *gzBtn;
    
    UIImageView *userimg;
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    
    SQCustomButton *btn1;
    SQCustomButton *btn2;
    
    NSString *webString;
}
@property(nonatomic ,strong)TestTableView * mainTableView;
@property(nonatomic,strong) UIScrollView * parentScrollView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,assign)BOOL canScroll;

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;


@end

@implementation HomeDetailsViewController
@synthesize mainTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.canScroll = YES;
    self.navigationItem.title = @"详情";
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MainTableScroll:) name:@"MainTableScroll" object:nil];
    
    [self.view addSubview:self.mainTableView];
    
    
    
    [self.mainTableView addSubview:self.headImageView];
    
    [self setTopViewOne];
    [self setTopViewTwo];
    
    [self lodDtata];
}
- (void)lodDtata{
    LRWeakSelf(self);
    NSDictionary *dic = @{@"pid":self.idString,
                          };
    [Manager post:KURLNSString(productDetails) RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        NSDictionary *dictions = [[dict objectForKey:@"data"] firstObject];
        self->webString = [dictions objectForKey:@"desc"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
        [array removeAllObjects];
        for (NSDictionary *dicc in [dictions objectForKey:@"imgSrc"]) {
            HomeModel *model = [HomeModel mj_objectWithKeyValues:dicc];
            [array addObject:model.img];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.cycleScrollView.imageURLStringsGroup = array;
            self->lab1.text = [NSString stringWithFormat:@"发布人：%@",[dictions objectForKey:@"seller"]];
        });
        NSLog(@"%@",dict);
    }];
}






- (void)setTopViewOne{
    topview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [self.headImageView addSubview:topview1];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) delegate:self placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    [topview1 addSubview:self.cycleScrollView];
    
    gzBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gzBtn.frame = CGRectMake(SCREEN_WIDTH-110, 450, 100, 30);
    gzBtn.backgroundColor = RGBACOLOR(190, 8, 7, 1);
    LRViewBorderRadius(gzBtn, 7, 0, UIColor.clearColor);
    [gzBtn setTitle:@"关注物品" forState:UIControlStateNormal];
    [gzBtn addTarget:self action:@selector(clickgz) forControlEvents:UIControlEventTouchUpInside];
    [self.headImageView addSubview:gzBtn];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
- (void)clickgz{
    NSLog(@"guanzhu---");
}
- (void)setTopViewTwo{
    topview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 145)];
    topview2.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [self.headImageView addSubview:topview2];
    
    userimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    userimg.image = [UIImage imageNamed:@"tx"];
    [topview2 addSubview:userimg];
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 150, 20)];
    //    lab1.text = @"发布人：惺惺相惜";
    [topview2 addSubview:lab1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 150, 20)];
    lab2.text = @"级别：777";
    [topview2 addSubview:lab2];
    
    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 150, 20)];
    lab3.text = @"信誉：666";
    [topview2 addSubview:lab3];
    
    btn1 = [[SQCustomButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-180, 60, 80, 80)
                                           type:SQCustomButtonTopImageType
                                      imageSize:CGSizeMake(30, 30) midmargin:10];
    btn1.isShowSelectBackgroudColor = NO;
    btn1.imageView.image = [UIImage imageNamed:@"gwly"];
    btn1.titleLabel.text = @"给我留言";
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.titleLabel.textColor = RGBACOLOR(190, 8, 7, 1);
    [topview2 addSubview:btn1];
    [btn1 touchAction:^(SQCustomButton * _Nonnull button) {
        
    }];
    
    btn2 = [[SQCustomButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, 60, 80, 80)
                                           type:SQCustomButtonTopImageType
                                      imageSize:CGSizeMake(30, 30) midmargin:10];
    btn2.isShowSelectBackgroudColor = NO;
    btn2.imageView.image = [UIImage imageNamed:@"nogzmj"];
    btn2.titleLabel.text = @"关注卖家";
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.titleLabel.textColor = RGBACOLOR(190, 8, 7, 1);
    [topview2 addSubview:btn2];
    [btn2 touchAction:^(SQCustomButton * _Nonnull button) {
        button.imageView.image = [UIImage imageNamed:@"isgzmj"];
        button.titleLabel.text = @"已关注";
    }];
}


























-(UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _headImageView.frame=CGRectMake(0, -headViewHeight ,SCREEN_WIDTH,headViewHeight);
        _headImageView.userInteractionEnabled = YES;
    }
    return _headImageView;
}



-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)MainTableScroll:(NSNotification *)user{
    
    self.canScroll = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==mainTableView) {
        
        CGFloat tabOffsetY = [mainTableView rectForSection:0].origin.y;
        CGFloat offsetY = scrollView.contentOffset.y;
        NSLog(@"tabOffsetY:%f",offsetY);
        if (offsetY>=tabOffsetY) {
            self.canScroll = NO;
            scrollView.contentOffset = CGPointMake(0, 0);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"childScrollCan" object:nil];
        }else{
            
            if (!self.canScroll) {
                
                [scrollView setContentOffset:CGPointZero];
            }
        }
    }
}

#pragma mark --tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_HEIGHT-64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChuRuCell *cell = [[ChuRuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /* 添加pageView
     * 这里可以任意替换你喜欢的pageView
     *作者这里使用一款github较多人使用的 WMPageController 地址https://github.com/wangmchn/WMPageController
     */
    [cell.contentView addSubview:self.setPageViewControllers];
    
    return cell;
}


#pragma mark -- setter/getter

-(UIView *)setPageViewControllers
{
    WMPageController *pageController = [self p_defaultController];
    pageController.title = @"Line";
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    return pageController.view;
}

- (WMPageController *)p_defaultController {
    OneViewTableTableViewController * oneVc  = [OneViewTableTableViewController new];
    SecondViewTableViewController * twoVc  = [SecondViewTableViewController new];
    DetailsThreeViewController * threeVc  = [DetailsThreeViewController new];

    
    NSArray *viewControllers = @[oneVc,twoVc,threeVc];
    
    NSArray *titles = @[@"卖出",@"购入",@"详情"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    [pageVC setViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    pageVC.delegate = self;
    pageVC.menuItemWidth = 85;
    pageVC.menuHeight = 44;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSLog(@"%@",viewController);
}





-(TestTableView *)mainTableView
{
    if (mainTableView == nil)
    {
        mainTableView= [[TestTableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64)];
        mainTableView.delegate=self;
        mainTableView.dataSource=self;
        mainTableView.showsVerticalScrollIndicator = NO;
        mainTableView.contentInset = UIEdgeInsetsMake(headViewHeight,0, 0, 0);
        mainTableView.backgroundColor = [UIColor clearColor];
        
    }
    return mainTableView;
}
@end
