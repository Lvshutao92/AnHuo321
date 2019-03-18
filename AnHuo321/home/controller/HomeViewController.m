//
//  HomeViewController.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/13.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "HomeCollectionViewCell.h"
#import "SearchController.h"
#import "HomeDetailsViewController.h"
#import "DetailsViewController.h"

static NSString *headerViewIdentifier = @"hederview";


@interface HomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PYSearchViewControllerDelegate>
{
    UIView *headerView;
    NSInteger number;
    NSInteger page;
}
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;

/** 换成集合视图 **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** header **/
@property (nonatomic, strong) UIView *headerV;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *bannerArray;


@end

@implementation HomeViewController
#pragma mark - 搜索
- (void)clicksearch{
    //1.创建热门搜索
    NSArray *hotSeaches = @[@"手机", @"电脑", @"桌子",  @"风扇"];
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"商品名称" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {

        SearchController *vc = [[SearchController alloc] init];
        vc.str = searchText;
        [searchViewController.navigationController pushViewController:vc animated:YES];

    }];
    searchViewController.hotSearchStyle = 4; // 热门搜索风格为默认【1，7】
    searchViewController.searchHistoryStyle = 2; // 搜索历史风格根据选择【1，6】
    searchViewController.delegate = self;
    MainNavigationViewController *nav = [[MainNavigationViewController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    [self.view addSubview:self.collectionView];

    [self lodBanner];
    [self setUpRefresh];
    // Do any additional setup after loading the view.
}




- (void)lodBanner{
    LRWeakSelf(self);
    [Manager post:KURLNSString(topLunBotu) RequestParams:@{} FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        //NSLog(@"---------%@",dict);
        dispatch_async(dispatch_get_global_queue(0,0),^{
            //轮播图
            [weakSelf.bannerArray removeAllObjects];
            for (NSDictionary *dit in [dict objectForKey:@"data"]) {
                HomeModel *model = [HomeModel mj_objectWithKeyValues:dit];
                [weakSelf.bannerArray addObject:model];
            }
            NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:1];
            for (HomeModel *model in self.bannerArray) {
                [imgArr addObject:model.imgSrc];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.cycleScrollView.imageURLStringsGroup = imgArr;
                [weakSelf.collectionView reloadData];
            });
        });
    }];
}

- (void)setUpRefresh{
    LRWeakSelf(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf lodA];
    }];
    [self.collectionView.mj_header beginRefreshing];

    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (weakSelf.dataArray.count == self->number) {
            [weakSelf.collectionView.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf lodB];
        }
    }];
}
- (void)lodA{
    page = 1;
    [self.collectionView.mj_footer endRefreshing];
    LRWeakSelf(self);
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%ld",page],
                          @"rows":@"12",
                          };
    [Manager post:KURLNSString(productList) RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        //        NSLog(@"---------%@",dict);
        dispatch_async(dispatch_get_global_queue(0,0),^{
            self->number = [[dict objectForKey:@"total"] integerValue];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *diction in [dict objectForKey:@"data"]) {
                HomeModel *model = [HomeModel mj_objectWithKeyValues:diction];
                [weakSelf.dataArray addObject:model];
            }
            self->page++;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView.mj_header endRefreshing];
            });
        });

    }];

}
- (void)lodB{
    [self.collectionView.mj_header endRefreshing];
    LRWeakSelf(self);
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%ld",page],
                          @"rows":@"12",
                          };
    [Manager post:KURLNSString(productList) RequestParams:dic FinishBlock:^(NSURLResponse * _Nonnull response, NSData * _Nonnull data, NSError * _Nonnull connectionError) {
        NSDictionary *dict = [Manager returndictiondata:data];
        //NSLog(@"---------%@",dict);
        dispatch_async(dispatch_get_global_queue(0,0),^{
            for (NSDictionary *diction in [dict objectForKey:@"data"]) {
                HomeModel *model = [HomeModel mj_objectWithKeyValues:diction];
                [weakSelf.dataArray addObject:model];
            }
            self->page++;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView.mj_footer endRefreshing];
            });
        });
    }];
}



#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    LRViewBorderRadius(cell.contentView, 0, .25, W_CA(.8, .3));
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    LRViewBorderRadius(cell.img, 5, 0, UIColor.clearColor);
    HomeModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.midImgSrc]];
    cell.lab.text = model.title;
    return cell;
}


#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model = [self.dataArray objectAtIndex:indexPath.row];
    DetailsViewController *goods = [[DetailsViewController alloc]init];
    goods.title = @"详情";
    goods.idString = model.productId;
    [self.navigationController pushViewController:goods animated:YES];
}



//collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout.alloc init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2, 235);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//竖直方向
        flowLayout.sectionInset = UIEdgeInsetsZero;
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;


        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}
//-----------------------顶部轮播图-----------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, self.headerV.frame.size.height);
    }
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header addSubview: self.headerV];
        return header;
    }
    return [UICollectionReusableView new];
}

- (UIView *)headerV {
    if (!_headerV) {
        _headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200*SCALE_HEIGHT)];
        [_headerV addSubview:self.cycleScrollView];
    }
    return _headerV;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200*SCALE_HEIGHT) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        
    }
    return _cycleScrollView;
}
//轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}











- (NSMutableArray *)bannerArray{
    if (_bannerArray == nil) {
        self.bannerArray = [NSMutableArray arrayWithCapacity:1];
    }
    return  _bannerArray;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
