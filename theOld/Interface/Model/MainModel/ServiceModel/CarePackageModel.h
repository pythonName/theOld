//
//  CarePackageModel.h
//  theOld
//
//  Created by test on 2018/1/2.
//  Copyright © 2018年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKNetworkBaseModel.h"

@interface CarePackageModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *updated_time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *shelf_time;
@property (nonatomic, copy) NSString *editor;
@property (nonatomic) NSInteger user_count;
@property (nonatomic) CGFloat price;
@property (nonatomic) CGFloat pack_progress;
@property (nonatomic) NSInteger effective_days;
@property (nonatomic) NSInteger available;

/*
 available = 1;
 content = "1\U3001\U9002\U7528\U4e8e\U9aa8\U6298\Uff08\U5982\U8170\U690e\U3001\U5173\U8282\U8131\U4f4d\U7b49\Uff09\U7684\U5c45\U5bb6\U8001\U4eba\n2\U3001\U4e24\U5468\U4e00\U6b21\U62a4\U58eb\U968f\U8bbf\n3\U3001\U6bcf\U5468\U516d\U5929\U3001\U6668\U3001\U665a\U95f4\U5404\U4e00\U6b21\U4e0a\U95e8\U670d\U52a1\n4\U3001\U7535\U52a85\U529f\U80fd4\U4f53\U667a\U80fd\U62a4\U7406\U5e8a";
 editor = lj;
 "effective_days" = 7;
 "end_time" = "2017-01-01";
 "pack_progress" = 114;
 price = 500;
 "shelf_time" = "Tue, 31 Oct 2017 00:00:00 GMT";
 "start_time" = "2017-12-26";
 title = "\U9aa8\U6298A\U5957\U9910";
 "updated_time" = "Thu, 19 Oct 2017 00:00:00 GMT";
 "user_count" = 1;

 */

@end
