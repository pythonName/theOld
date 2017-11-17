//
//  VerifyIdentityCard.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/17.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyIdentityCard : NSObject
+(BOOL)validateIDCardNumber:(NSString *)value;
@end
