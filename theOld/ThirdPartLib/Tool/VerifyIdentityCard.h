//
//  VerifyIdentityCard.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/17.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyIdentityCard : NSObject

//验证身份证号的方法
+(BOOL)validateIDCardNumber:(NSString *)value;

//验证手机号的方法
+ (BOOL) isPhoneNumber:(NSString *)mobileNum;


//验证邮箱
+ (BOOL) isEmailAdress:(NSString *)Email;

@end
