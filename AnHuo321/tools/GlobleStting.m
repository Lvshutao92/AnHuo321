//
//  GlobleStting.m
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/14.
//  Copyright © 2019 macbookpro. All rights reserved.
//
#define KIsFirst        @"isfisrt"

#import "GlobleStting.h"
//---只被创建一次；
static GlobleStting * globleStting;
@interface GlobleStting()

@end
@implementation GlobleStting
+(GlobleStting*)shareGlobalSettingInstance
{
    //--使用GCD不消耗内存；
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!globleStting) {
            globleStting =[[self alloc] init];
        }
    });
    return globleStting;
}
+ (void)loadingSvProgressView
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];//--圆圈的背景色
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD showWithStatus:@"加载中。。。"];
}
+(void)setPassword:(NSString *)password{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"pwd"];
    [userDefaults synchronize];
}
+(void)setUsername:(NSString *)name{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:name forKey:@"username"];
    [userDefaults synchronize];
}

+ (NSString*)getusername
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if ([[userDefaults valueForKey:@"username"] length]==0) {
        return @"";
    }
    return [userDefaults valueForKey:@"username"];
}
+ (NSString*)getpwd
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if ([[userDefaults valueForKey:@"pwd"] length]==0) {
        return @"";
    }
    return [userDefaults valueForKey:@"pwd"];
}

-(void)setIsFirst:(BOOL)isFirst{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:isFirst] forKey:KIsFirst];
    [userDefaults synchronize];
}
-(BOOL)isFirst{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:KIsFirst];
}

@end
