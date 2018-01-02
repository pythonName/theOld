//
//  TheOldAccountDetailResponseModel.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/23.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"
@class OldAccountDataList;

@interface TheOldAccountDetailResponseModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray <OldAccountDataList *> *data;

@property (nonatomic, assign) NSInteger code;

@end

@interface OldAccountDataList : YKNetworkBaseModel

@property (nonatomic, copy) NSString *editor;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, assign) NSInteger available;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger effective_days;

@property (nonatomic, copy) NSString *shelf_time;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *updated_time;

@property (nonatomic, assign) NSInteger user_count;

@property (nonatomic, copy) NSString *pack_progress;

@end
