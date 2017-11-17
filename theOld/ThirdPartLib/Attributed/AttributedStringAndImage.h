//
//  AttributedStringAndImage.h
//  byd_c
//
//  Created by 拓润公司 on 2017/4/27.
//  Copyright © 2017年 拓润公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributedStringAndImage : NSObject

//设置一个lable(uibutton 等)显示两种字体格式（第一种样式 color1，font1）（第二种样式 color2，font2）
///同一个字符串
+(NSMutableAttributedString*)initNSMutableAttributedString:(NSString*)string
                                                 withFont1:(CGFloat)font1
                                                withColor1:(UIColor*)color1
                                                withRange1:(NSRange)range1
                                                 withFont2:(CGFloat)font2
                                                withColor2:(UIColor*)color2
                                                withRange2:(NSRange)range2;

//设置一个lable(uibutton 等)显示图片和文字（第一种样式 color1，font1），image1图片名字
//prefixBool== Yes图片放在文字的前面
+(NSMutableAttributedString*)initNSMutableAttributedString:(NSString*)string
                                                 withFont1:(CGFloat)font1
                                                withColor1:(UIColor*)color1
                                                withRange1:(NSRange)range1
                                                 withImage:(NSString*)imageName
                                           withImagePrefix:(BOOL)prefixBool;

//设置一个lable 带1 的是第一个字符串的样式，带2 的是第2个字符串的样式
//不同字符串
+(NSMutableAttributedString*)initNSMutableAttributedString:(NSString*)string1
                                                 withFont1:(CGFloat)font1
                                                withColor1:(UIColor*)color1
                                                 withString:(NSString*)string2
                                                 withFont2:(CGFloat)font2
                                                withColor2:(UIColor*)color2;

@end
