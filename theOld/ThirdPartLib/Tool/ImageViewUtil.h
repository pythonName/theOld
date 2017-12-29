//
//  ImageViewUtil.h
//  theOld
//
//  Created by test on 2017/12/29.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"

@interface ImageViewUtil : NSObject

+ (void)setImage:(UIImageView *)imageView imageURL:(NSString *)imageURL placeholder:(NSString *)placeholder;

+ (void)setNoCacheImage:(UIImageView *)imageView imageURL:(NSString *)imageURL;

@end
