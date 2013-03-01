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
    return [[NSCalendar currentCalendar] components:unitFlags fromDate:self toDate:endDate options:0];
}

-(NSDateComponents*)components:(unsigned int)unitFlags
{
    return [self components:unitFlags toDate:nil];
}

-(NSDateComponents*)componentsAll
{
    return [self components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit];
}

-(NSDateComponents*)componentsAllToDate:(NSDate*)endDate
{
    return [self components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit toDate:endDate];
}

@end
