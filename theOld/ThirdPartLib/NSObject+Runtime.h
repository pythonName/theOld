//
//  NSObject+Runtime.h
//  cop
//
//  Created by lizhenzhen on 15/5/30.
//
//

#import <Foundation/Foundation.h>

@interface NSObject(Runtime)

- (NSDictionary *)properties_aps;
- (NSArray *)getAllProperties;
- (NSDictionary *)getAllPropertiesAndType;
- (void)getMothList;
- (void)getAllVars;

@end
