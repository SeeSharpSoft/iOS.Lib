//
//  NSObject+Sharp.m
//  iOSLib
//
//  Created by Sommer, Martin on 01.03.13.
//  Copyright (c) 2013 Sommer, Martin. All rights reserved.
//

#import "NSObject+Sharp.h"
#import <objc/runtime.h>

@implementation NSObject (Sharp)

/*
 * @returns A string describing the type of the property
 */

+ (NSString *)propertyTypeStringOfProperty:(objc_property_t) property {
    const char *attr = property_getAttributes(property);
    NSString *const attributes = [NSString stringWithCString:attr encoding:NSUTF8StringEncoding];
    
    NSRange const typeRangeStart = [attributes rangeOfString:@"T@\""];  // start of type string
    if (typeRangeStart.location != NSNotFound) {
        NSString *const typeStringWithQuote = [attributes substringFromIndex:typeRangeStart.location + typeRangeStart.length];
        NSRange const typeRangeEnd = [typeStringWithQuote rangeOfString:@"\""]; // end of type string
        if (typeRangeEnd.location != NSNotFound) {
            NSString *const typeString = [typeStringWithQuote substringToIndex:typeRangeEnd.location];
            return typeString;
        }
    }
    return nil;
}

/**
 * @returns (NSString) Dictionary of property name --> type
 */

+ (NSDictionary *)propertyTypeDictionaryOfClass:(Class)clazz {
    NSMutableDictionary *propertyMap = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            
            NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            NSString *propertyType = [self propertyTypeStringOfProperty:property];
            [propertyMap setValue:propertyType forKey:propertyName];
        }
    }
    free(properties);
    return propertyMap;
}

- (NSDictionary *)propertyTypeDictionary
{
    return [NSObject propertyTypeDictionaryOfClass:[self class]];
}

@end
