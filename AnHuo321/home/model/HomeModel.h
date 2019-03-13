//
//  HomeModel.h
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/13.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
//首页产品列表
@property(nonatomic,strong)NSString *midImgSrc;
@property(nonatomic,strong)NSString *productId;
@property(nonatomic,strong)NSString *title;
//轮播图
@property(nonatomic,strong)NSString *href;
@property(nonatomic,strong)NSString *imgSrc;
@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSString *img;
@end

NS_ASSUME_NONNULL_END
