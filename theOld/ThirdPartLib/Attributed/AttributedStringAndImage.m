//
//  AttributedStringAndImage.m
//  byd_c
//
//  Created by 拓润公司 on 2017/4/27.
//  Copyright © 2017年 拓润公司. All rights reserved.
//

#import "AttributedStringAndImage.h"

@implementation AttributedStringAndImage


+(NSMutableAttributedString*)initNSMutableAttributedString:(NSString*)string
                                                 withFont1:(CGFloat)font1
                                                withColor1:(UIColor*)color1
                                                withRange1:(NSRange)range1
                                                 withFont2:(CGFloat)font2
                                                withColor2:(UIColor*)color2
                                                withRange2:(NSRange)range2
{
    if([string isKindOfClass:[NSNull class]] || string == nil){
        string = @"";
    }
    //这里是一个字符串两种样式
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString: string];
    
    [attributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font1],NSForegroundColorAttributeName:color1} range:range1];
    
    if (color2 != nil) {
        [attributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font2],NSForegroundColorAttributeName:color2} range:range2];
    }
    
    return attributeString;
}


+(NSMutableAttributedString*)initNSMutableAttributedString:(NSString*)string
                                                 withFont1:(CGFloat)font1
                                                withColor1:(UIColor*)color1
                                                withRange1:(NSRange)range1
                                                 withImage:(NSString*)imageName
                                           withImagePrefix:(BOOL)prefixBool
{
    if([string isKindOfClass:[NSNull class]] || string == nil){
        string = @"";
    }
    //这里是字符串和图片组合的样式
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString: string];
    
    [attributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font1],NSForegroundColorAttributeName:color1} range:range1];
    
    
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imageName];
    NSAttributedString *attributeImage = [NSAttributedString attributedStringWithAttachment:attach];
    if (prefixBool) {
        [attributeString insertAttributedString:attributeImage atIndex:0];
    }else{
        [attributeString appendAttributedString:attributeImage];
    }
    
    
    return attributeString;
}

+(NSMutableAttributedString*)initNSMutableAttributedString:(NSString*)string1
                                                 withFont1:(CGFloat)font1
                                                withColor1:(UIColor*)color1
                                                withString:(NSString*)string2
                                                 withFont2:(CGFloat)font2
                                                withColor2:(UIColor*)color2 {
    if([string1 isKindOfClass:[NSNull class]] || string1 == nil){
        string1 = @"";
    }
    //这里是两个字符串两个样式
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString: string1];
    [attributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font1],NSForegroundColorAttributeName:color1} range:NSMakeRange(0, string1.length)];
    
    if (string2.length>0) {
        NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc]initWithString: string2];
        [attributeString2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font2],NSForegroundColorAttributeName:color2} range:NSMakeRange(0, string2.length)];
        
        [attributeString appendAttributedString:attributeString2];
    }
    
    
    return attributeString;
}

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value andWidth:(float)width fontSize:(CGFloat)fontSize{
    //获取当前文本的属性
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
 
//    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
//    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
    // 计算文本的大小
//    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
//                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
//                                        attributes:dic        // 文字的属性
//                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height;
}


 

@end
