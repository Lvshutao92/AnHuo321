//
//  Header.h
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/13.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define KURLNSString(str) [NSString stringWithFormat:@"http://321ah.com/%@",str]

#define productList    @"Appapi/getProductsList"//产品列表 page rows

#define topLunBotu     @"Appapi/getBannerImage"//顶部轮播图

#define productDetails @"Appapi/getProductsDetails"//商品详情 pid

#define morePrice      @"Appapi/getMoreRecord"//更多出价 pid

#define lookPingJia    @"Appapi/viewComments"//查看评价 pid

#define search         @"Appapi/search"//搜索 keywords

#define guanzhu        @"Appapi/setAttention"//物品关注、取消  pid result=2关注成功 =3取消成功

#define gzJiaoYiList   @"Appapi/getAttention"//我关注的交易列表 page rows

#define changePwd      @"Appapi/resetPassword"//更改密码 pwd

#define baseInfo       @"Appapi/getUserInfo"//基本信息 account

#define baseInfoEdit   @"Appapi/editUserInfo"//基本信息编辑

#define addressPro     @"Appapi/getProvince"//获取省、市 province_id 可不跟，省市列表全查

#define addressCity    @"Appapi/getCity"//获取市/区县列表 province_id 必传


#endif /* Header_h */
