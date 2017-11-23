//
//  NSObject+Runtime.m
//  cop
//
//  Created by lizhenzhen on 15/5/30.
//
//

#import <objc/runtime.h>
#import "NSObject+Runtime.h"

@implementation NSObject(Runtime)

/* 获取对象的所有属性 以及属性值 [所有声明在.h和.m文件中的property都可获取]*/
- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];//获取出的值不用管是对象还是基础数据类型，一律为对象型
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    return props;
}

/* 获取对象的所有属性，不包括属性值 [所有声明在.h和.m文件中的property都可获取]*/
- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    return propertiesArray;
}

/* 获取对象的所有属性及属性的类型，不包括属性值 [所有声明在.h和.m文件中的property都可获取]*/
- (NSDictionary *)getAllPropertiesAndType
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableDictionary *propertiesDic = [NSMutableDictionary dictionaryWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        const char* propertyType =property_getAttributes(properties[i]);
        [propertiesDic setObject:[NSString stringWithUTF8String: propertyType] forKey:[NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    return propertiesDic;
}

/* 获取对象的所有方法 */
-(void)getMothList
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
        //IMP imp_f = method_getImplementation(temp_f);
        //SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,[NSString stringWithUTF8String:encoding]);
    }
    
    free(mothList_f);
}

/*获取对象所有的成员变量，属性的成员变量标示就多一下划线 [所有声明在.h和.m文件中的property都可获取]*/
- (void)getAllVars {
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList([self class], &numIvars);
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        
        NSLog(@"variable name :%@", key);
        
        key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        
        NSLog(@"variable type :%@", key);
    }
    
    free(vars);
}

@end
