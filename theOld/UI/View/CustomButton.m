//
//  CustomButton.m
//  theOld
//
//  Created by test on 2018/1/12.
//  Copyright © 2018年 loary. All rights reserved.
//

#import "CustomButton.h"

#define BottomPadding 0

@implementation CustomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//    NSString *title = self.currentTitle;
//    CGFloat titleH = [self getTitleRect:title].size.height;
    
    CGFloat btnH = contentRect.size.height;
    
    CGFloat imageW = contentRect.size.width / 2;
    CGFloat imageH = imageW;
    CGFloat imageX = contentRect.size.width / 4;
    CGFloat imageY = (btnH - imageH - BottomPadding) / 2;
    
    return CGRectMake(imageX, imageY, imageW, imageH );
}

//- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//
//    CGFloat btnH = contentRect.size.height;
//    CGFloat titleH = [self getTitleRect:self.currentTitle].size.height;
//    CGFloat titleX = 0;
//    CGFloat titleY = btnH - titleH - BottomPadding;
//    CGFloat titleW = contentRect.size.width;
//
//    return CGRectMake(titleX, titleY, titleW, titleH);
//}
//
//- (CGRect)getTitleRect:(NSString *)title{
//    CGSize masSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSFontAttributeName] = _titleFont;
//    return [title boundingRectWithSize:masSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
//}

@end
