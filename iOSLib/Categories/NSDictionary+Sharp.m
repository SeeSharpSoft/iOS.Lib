//
//  NSDictionary+Sharp.m
//  iOSLib
//
//  Created by Sommer, Martin on 01.03.13.
//  Copyright (c) 2013 Sommer, Martin. All rights reserved.
//

#import "NSDictionary+Sharp.h"
#import "NSObject+Sharp.h"

@implementation NSDictionary (Sharp)

+(NSDictionary*)dictionaryWithObject:(NSObject*)obj
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    NSDictionary *properties = [obj propertyTypeDictionary];
    for(NSString *key in [properties keyEnumerator])
    {
        [result setObject:[obj valueForKey:key] forKey:key];
    }
    return result;
}



@end
