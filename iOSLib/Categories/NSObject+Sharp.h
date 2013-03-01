//
//  NSObject+Sharp.h
//  iOSLib
//
//  Created by Sommer, Martin on 01.03.13.
//  Copyright (c) 2013 Sommer, Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Sharp)

+ (NSDictionary *)propertyTypeDictionaryOfClass:(Class)clazz;

- (NSDictionary *)propertyTypeDictionary;

@end
