//
//  CareOldManModel.m
//  theOld
//
//  Created by test on 2017/12/27.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "CareOldManModel.h"

@implementation CareOldManModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ID_number forKey:@"ID_number"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_addtime forKey:@"addtime"];
    [aCoder encodeObject:_area forKey:@"area"];
    [aCoder encodeObject:_body forKey:@"body"];
    [aCoder encodeObject:_cell_phone forKey:@"cell_phone"];
    [aCoder encodeObject:_fix_phone forKey:@"fix_phone"];
    [aCoder encodeObject:[NSNumber numberWithInteger:_is_delete] forKey:@"is_delete"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_photo forKey:@"photo"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_pack_progress forKey:@"pack_progress"];
    [aCoder encodeObject:[NSNumber numberWithInteger:_count] forKey:@"count"];
    [aCoder encodeObject:[NSNumber numberWithInteger:_age] forKey:@"age"];
    
}
/*
 @property (nonatomic, copy) NSString *ID_number;
 @property (nonatomic, copy) NSString *address;
 @property (nonatomic, copy) NSString *addtime;
 @property (nonatomic, copy) NSString *area;
 @property (nonatomic, copy) NSString *body;
 @property (nonatomic, copy) NSString *cell_phone;
 @property (nonatomic, copy) NSString *fix_phone;
 @property (nonatomic) NSInteger is_delete;
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *photo;
 @property (nonatomic, copy) NSString *sex;
 @property (nonatomic, copy) NSString *pack_progress;    //服务进度
 @property (nonatomic,assign) NSInteger count;  //监护人数量
 @property (nonatomic,assign) NSInteger age;//
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.ID_number = [aDecoder decodeObjectForKey:@"ID_number"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.addtime = [aDecoder decodeObjectForKey:@"addtime"];
        self.age = [[aDecoder decodeObjectForKey:@"age"] integerValue];
        self.area = [aDecoder decodeObjectForKey:@"area"];
        self.body = [aDecoder decodeObjectForKey:@"body"];
        self.cell_phone = [aDecoder decodeObjectForKey:@"cell_phone"];
        self.fix_phone = [aDecoder decodeObjectForKey:@"fix_phone"];
        self.is_delete = [[aDecoder decodeObjectForKey:@"is_delete"] integerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.photo = [aDecoder decodeObjectForKey:@"photo"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.pack_progress = [aDecoder decodeObjectForKey:@"pack_progress"];
        self.count = [[aDecoder decodeObjectForKey:@"count"] integerValue];
        return self;
    }
    else{
        return nil;
    }
}

@end
