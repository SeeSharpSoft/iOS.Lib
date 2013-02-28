//
//  NSArray+Sharp.m
//  iOSLib
//
//  Created by Sommer, Martin on 28.02.13.
//  Copyright (c) 2013 Sommer, Martin. All rights reserved.
//

#import "NSArray+Sharp.h"

@implementation NSArray (Sharp)

- (NSArray *)where:(Predicate)predicate
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for(id item in self) {
        if (predicate(item)) {
            [result addObject:item];
        }
    }
    return result;
}

- (NSArray *)select:(Selector)transform
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for(id item in self) {
        [result addObject:transform(item)];
    }
    return result;
}

- (NSArray *)sort:(Selector)keySelector
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        id valueOne = keySelector(obj1);
        id valueTwo = keySelector(obj2);
        NSComparisonResult result = [valueOne compare:valueTwo];
        return result;
    }];
}

- (NSArray *)sort
{
    return [self sort:^id(id item) { return item;} ];
}

- (NSArray *)ofType:(Class)type
{
    return [self where:^BOOL(id item) {
        return [[item class] isSubclassOfClass:type];
    }];
}

- (NSArray *)selectMany:(Selector)transform
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for(id item in self) {
        [result addObjectsFromArray:transform(item)];
    }
    return result;
}

- (NSArray *)distinct
{
    NSMutableArray* distinctSet = [[NSMutableArray alloc] init];
    for (id item in self) {
        if (![distinctSet containsObject:item]) {
            [distinctSet addObject:item];
        }
    }
    return distinctSet;
}

- (id)aggregate:(Accumulator)accumulator
{
    id aggregate = nil;
    for (id item in self) {
        if (aggregate == nil) {
            aggregate = item;
        } else {
            aggregate = accumulator(item, aggregate);
        }
    }
    return aggregate;
}

- (id)firstOrNil
{
    return [self firstOrNil:^BOOL(id obj) {
        return YES;
    }];
}

- (id)lastOrNil
{
    return [self lastOrNil:^BOOL(id obj) {
        return YES;
    }];
}

- (NSArray*)skip:(NSUInteger)count
{
    if (count < self.count) {
        NSRange range = {.location = count, .length = self.count - count};
        return [self subarrayWithRange:range];
    } else {
        return @[];
    }
}

- (NSArray*)take:(NSUInteger)count
{
    NSRange range = { .location=0,
        .length = count > self.count ? self.count : count};
    return [self subarrayWithRange:range];
}

- (BOOL)any:(Condition)condition
{
    for (id item in self) {
        if (condition(item)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)all:(Condition)condition
{
    for (id item in self) {
        if (!condition(item)) {
            return NO;
        }
    }
    return YES;
}

- (NSDictionary*)groupBy:(Selector)groupKeySelector
{
    NSMutableDictionary* groupedItems = [[NSMutableDictionary alloc] init];
    for (id item in self) {
        id key = groupKeySelector(item);
        NSMutableArray* arrayForKey;
        if (!(arrayForKey = [groupedItems objectForKey:key])){
            arrayForKey = [[NSMutableArray alloc] init];
            [groupedItems setObject:arrayForKey forKey:key];
        }
        [arrayForKey addObject:item];
    }
    return groupedItems;
}

- (NSDictionary *)toDictionaryWithKeySelector:(Selector)keySelector valueSelector:(Selector)valueSelector
{
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    for (id item in self) {
        id key = keySelector(item);
        id value = valueSelector!=nil ? valueSelector(item) : item;
        [result setObject:value forKey:key];
    }
    return result;
}

- (NSDictionary *)toDictionaryWithKeySelector:(Selector)keySelector
{
    return [self toDictionaryWithKeySelector:keySelector valueSelector:nil];
}



- (id) firstOrNil:(Condition)condition
{
    for(id obj in self)
    {
        if(condition(obj)) return obj;
    }
    return nil;
}

- (id) lastOrNil:(Condition)condition
{
    for(id obj in [self reverseObjectEnumerator])
    {
        if(condition(obj)) return obj;
    }
    return nil;
}

- (NSArray*)reverse
{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSNumber*)sum
{
    NSNumber *result = [[NSNumber alloc] init];
    for(id obj in self)
    {
        result += (NSNumber)obj;
    }
    return result;
}

@end
