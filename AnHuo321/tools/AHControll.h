//
//  AHControll.h
//  AnHuo321
//
//  Created by 吕书涛 on 2019/3/14.
//  Copyright © 2019 macbookpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AHControll : NSObject

#pragma mark --判断设备型号
+(NSString *)platformString;
#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text textColor:(UIColor*)color NSTextAlignment:(NSTextAlignment)Alignment;
#pragma mark --创建View
+(UIView*)viewWithFrame:(CGRect)frame viewColor:(UIColor*)color;
#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
#pragma mark --创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action;


+(UIButton*)createButtonNormalFrame:(CGRect)frame Target:(id)target Action:(SEL)action Title:(NSString*)title TitleColor:(UIColor*)textColor Font:(CGFloat)font BackGColor:(UIColor*)backColor;

#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;
#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder textColor:(UIColor*)textColor Font:(float)font Alignment:(NSTextAlignment)textAlignment;

#pragma mark 创建UIScrollView
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size;
#pragma mark 创建UIPageControl
+(UIPageControl*)makePageControlWithFram:(CGRect)frame;

#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;


#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval;

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize;

+ (NSString *)addOneByIntegerString:(NSString *)integerString;

#pragma 设置渐变色
+ (void)setJianBianSe:(UIButton *)btn;
+ (void)setJianBianSeGreay:(UIButton *)btn;
#pragma 返回字符串宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

#pragma 创建UIProgressView进度条
+(UIProgressView*)makeProgressViewWithFrame:(CGRect)rect AndProgress:(float )progress AndProgressColor:(UIColor *)color;

@end
