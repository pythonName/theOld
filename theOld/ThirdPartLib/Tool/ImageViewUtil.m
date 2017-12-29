//
//  ImageViewUtil.m
//  theOld
//
//  Created by test on 2017/12/29.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ImageViewUtil.h"

@implementation ImageViewUtil

+ (void)setImage:(UIImageView *)imageView imageURL:(NSString *)imageURL placeholder:(NSString *)placeholder{
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:placeholder] options:SDWebImageRefreshCached];
}

+ (void)setNoCacheImage:(UIImageView *)imageView imageURL:(NSString *)imageURL{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    imageView.image = [[UIImage alloc] initWithData:imageData];
}

@end
