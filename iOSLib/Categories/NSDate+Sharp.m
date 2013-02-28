//
//  NSDate+Sharp.m
//  iOSLib
//
//  Created by Sommer, Martin on 28.02.13.
//  Copyright (c) 2013 Sommer, Martin. All rights reserved.
//

#import "NSDate+Sharp.h"

@implementation NSDate (Sharp)

-(NSDateComponents*)components:(unsigned int)unitFlags toDate:(NSDate*)endDate
{
    return [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self toDate:endDate options:0];
}

-(NSDateComponents*)components:(unsigned int)unitFlags
{
    return [self components:unitFlags toDate:nil];
}

-(NSDateComponents*)componentsAll
{
    return [self components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit];
}

-(NSDateComponents*)componentsAllToDate:(NSDate*)endDate
{
    return [self components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit toDate:endDate];
}

@end
