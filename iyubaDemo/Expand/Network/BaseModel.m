//
//  BaseModel.m
//  iyubaDemo
//
//  Created by nice2meet on 2018/3/2.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (NSString *)description{
    
    NSString *description = NSStringFromClass([self class]);
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++){
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        description = [description stringByAppendingString:[NSString stringWithFormat:@"\n%@ = %@",propertyName,[self valueForKey:propertyName]]];
    }
    return description;
}
@end
