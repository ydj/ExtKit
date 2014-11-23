//  NSDate+ExtensionExt.m
//
//  Copyright (c) 2014 YDJ ( https://github.com/ydj/ExtKit )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.



#import "NSDate+ExtensionExt.h"

#define SECONDS_IN_MINUTE 60
#define MINUTES_IN_HOUR 60
#define DAYS_IN_WEEK 7
#define SECONDS_IN_HOUR (SECONDS_IN_MINUTE * MINUTES_IN_HOUR)
#define HOURS_IN_DAY 24
#define SECONDS_IN_DAY (HOURS_IN_DAY * SECONDS_IN_HOUR)

@implementation NSDate (ExtensionExt)

+(NSDate *)dateWithIntervalMonthFromDate_Ext:(NSDate *)date intervalMonth:(NSInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

- (NSDate *)dateWithIntervalMonth_Ext:(NSInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    return mDate;
}

+ (NSDate *)dateWithIntervalDayFromDate_Ext:(NSDate *)date intervalDay:(NSInteger)day
{
  return  [date dateByAddingTimeInterval:day*SECONDS_IN_DAY];
}

- (NSDate *)dateWithIntervalDay_Ext:(NSInteger)day
{
    return [self dateByAddingTimeInterval:day*SECONDS_IN_DAY];
}

#pragma mark - private
+ (NSCalendar *)AZ_currentCalendar {
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar *currentCalendar = [dictionary objectForKey:@"AZ_currentCalendar"];
    if (currentCalendar == nil) {
        currentCalendar = [NSCalendar currentCalendar];
        [dictionary setObject:currentCalendar forKey:@"AZ_currentCalendar"];
    }
    return currentCalendar;
}
#pragma mark - Relative dates from the current date
+ (NSDate *)dateTomorrow_Ext {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] + (SECONDS_IN_DAY * 1);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)dateYesterday_Ext {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] - (SECONDS_IN_DAY * 1);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)dateWithDaysFromNow_Ext:(NSInteger) dDays {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] + (SECONDS_IN_DAY * dDays);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)dateWithDaysBeforeNow_Ext:(NSInteger) dDays {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] - (SECONDS_IN_DAY * dDays);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)dateWithHoursFromNow_Ext:(NSInteger) dHours {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] + (SECONDS_IN_HOUR * dHours);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)dateWithHoursBeforeNow_Ext:(NSInteger) dHours {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] - (SECONDS_IN_HOUR * dHours);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)dateWithMinutesFromNow_Ext:(NSInteger) dMinutes {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] + (SECONDS_IN_MINUTE * dMinutes);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

+ (NSDate *)dateWithMinutesBeforeNow_Ext:(NSInteger) dMinutes {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] - (SECONDS_IN_MINUTE * dMinutes);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

#pragma mark - Comparing dates
- (BOOL)isEqualToDateIgnoringTime_Ext:(NSDate *) otherDate {
    NSCalendar *currentCalendar = [NSDate AZ_currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components1 = [currentCalendar components:unitFlags fromDate:self];
    NSDateComponents *components2 = [currentCalendar components:unitFlags fromDate:otherDate];
    return (components1.year == components2.year) &&
        (components1.month == components2.month) &&
        (components1.day == components2.day);
}

- (BOOL)isToday_Ext {
    return [self isEqualToDateIgnoringTime_Ext:[NSDate date]];
}

- (BOOL)isTomorrow_Ext {
    return [self isEqualToDateIgnoringTime_Ext:[NSDate dateTomorrow_Ext]];
}

- (BOOL)isYesterday_Ext {
    return [self isEqualToDateIgnoringTime_Ext:[NSDate dateYesterday_Ext]];
}

- (BOOL)isSameWeekAsDate_Ext:(NSDate *) aDate {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitWeekOfYear fromDate:self];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitWeekOfYear fromDate:aDate];
    if (components1.weekOfYear != components2.weekOfYear) {
        return NO;
    }
    return (fabs([self timeIntervalSinceDate:aDate]) < (SECONDS_IN_DAY * DAYS_IN_WEEK));
}

- (BOOL)isThisWeek_Ext {
    return [self isSameWeekAsDate_Ext:[NSDate date]];
}

- (BOOL)isNextWeek_Ext {
    NSDate *nextWeek = [NSDate dateWithDaysFromNow_Ext:DAYS_IN_WEEK];
    return [self isSameWeekAsDate_Ext:nextWeek];
}

- (BOOL)isLastWeek_Ext {
    NSDate *lastWeek = [NSDate dateWithDaysBeforeNow_Ext:DAYS_IN_WEEK];
    return [self isSameWeekAsDate_Ext:lastWeek];
}

- (BOOL)isSameMonthAsDate_Ext:(NSDate *) aDate {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *componentsArgs = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    if (componentsSelf.year != componentsArgs.year || componentsSelf.month != componentsArgs.month) {
        return NO;
    }
    return YES;
}

- (BOOL)isThisMonth_Ext {
    return [self isSameMonthAsDate_Ext:[NSDate date]];
}

- (BOOL)isSameYearAsDate_Ext:(NSDate *) aDate {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *componentsArgs = [calendar components:NSCalendarUnitYear fromDate:aDate];
    if (componentsSelf.year != componentsArgs.year) {
        return NO;
    }
    return YES;
}

- (BOOL)isThisYear_Ext {
    return [self isSameYearAsDate_Ext:[NSDate date]];
}

- (BOOL)isNextYear_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *componentsNextYear = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    componentsNextYear.year += 1;
    if (componentsSelf.year != componentsNextYear.year) {
        return NO;
    }
    return YES;
}

- (BOOL)isLastYear_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *componentsLastYear = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    componentsLastYear.year -= 1;
    if (componentsSelf.year != componentsLastYear.year) {
        return NO;
    }
    return YES;
}

- (BOOL)isEarlierThanDate_Ext:(NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate_Ext:(NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isEarlierThanOrEqualDate_Ext:(NSDate *) aDate {
    NSComparisonResult comparisonResult = [self compare:aDate];
    return (comparisonResult == NSOrderedAscending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isLaterThanOrEqualDate_Ext:(NSDate *) aDate {
    NSComparisonResult comparisonResult = [self compare:aDate];
    return (comparisonResult == NSOrderedDescending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isInPast_Ext {
    return [self isEarlierThanDate_Ext:[NSDate date]];
}

- (BOOL)isInFuture_Ext {
    return [self isLaterThanDate_Ext:[NSDate date]];
}


#pragma mark - Date roles
// https://github.com/erica/NSDate-Extensions/issues/12
- (BOOL)isTypicallyWorkday_Ext {
    return ([self isTypicallyWeekend_Ext] == NO);
}

- (BOOL)isTypicallyWeekend_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSRange weekdayRange = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSInteger weekdayOfDate = [components weekday];
    if (weekdayOfDate == weekdayRange.location || weekdayOfDate == weekdayRange.length) {
        return YES;
    }
    return NO;
}

#pragma mark - Adjusting dates
- (NSDate *)dateByAddingYears_Ext:(NSInteger) dYears {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = dYears;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingYears_Ext:(NSInteger) dYears {
    return [self dateByAddingYears_Ext:-dYears];
}

- (NSDate *)dateByAddingMonths_Ext:(NSInteger) dMonths {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = dMonths;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingMonths_Ext:(NSInteger) dMonths {
    return [self dateByAddingMonths_Ext:-dMonths];
}

- (NSDate *)dateByAddingDays_Ext:(NSInteger) dDays {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = dDays;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingDays_Ext:(NSInteger) dDays {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -dDays;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];

}

- (NSDate *)dateByAddingHours_Ext:(NSInteger) dHours {
    return [self dateByAddingTimeInterval:(SECONDS_IN_HOUR * dHours)];
}

- (NSDate *)dateBySubtractingHours_Ext:(NSInteger) dHours {
    return [self dateByAddingTimeInterval:-(SECONDS_IN_HOUR * dHours)];
}

- (NSDate *)dateByAddingMinutes_Ext:(NSInteger) dMinutes {
    return [self dateByAddingTimeInterval:(SECONDS_IN_MINUTE * dMinutes)];
}

- (NSDate *)dateBySubtractingMinutes_Ext:(NSInteger) dMinutes {
    return [self dateByAddingTimeInterval:-(SECONDS_IN_MINUTE * dMinutes)];
}

- (NSDate *)dateAtStartOfDay_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfWeek_Ext
{
    NSDate *startOfWeek = nil;
    [[NSDate AZ_currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&startOfWeek interval:NULL forDate:self];
    return startOfWeek;
}

- (NSDate *)dateAtEndOfWeek_Ext
{
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYearForWeekOfYear | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:self];
    components.weekday = range.length;
    return [calendar dateFromComponents:components];
}
- (NSDate *)dateAtStartOfMonth_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = range.location;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtEndOfMonth_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = range.length;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfYear_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = dayRange.location;
    components.month = monthRange.location;
    NSDate *startOfYear = [calendar dateFromComponents:components];
    return startOfYear;
}

- (NSDate *)dateAtEndOfYear_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = dayRange.length;
    components.month = monthRange.length;
    NSDate *endOfYear = [calendar dateFromComponents:components];
    return endOfYear;
}


#pragma mark - Retrieving intervals
- (NSInteger)minutesAfterDate_Ext:(NSDate *) aDate {
    NSTimeInterval timeIntervalSinceDate = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(timeIntervalSinceDate / SECONDS_IN_MINUTE);
}

- (NSInteger)minutesBeforeDate_Ext:(NSDate *) aDate {
    NSTimeInterval timeIntervalSinceDate = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(timeIntervalSinceDate / SECONDS_IN_MINUTE);
}

- (NSInteger)hoursAfterDate_Ext:(NSDate *) aDate {
    NSTimeInterval timeIntervalSinceDate = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(timeIntervalSinceDate / SECONDS_IN_HOUR);
}

- (NSInteger)hoursBeforeDate_Ext:(NSDate *) aDate {
    NSTimeInterval timeIntervalSinceDate = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(timeIntervalSinceDate / SECONDS_IN_HOUR);
}

- (NSInteger)daysAfterDate_Ext:(NSDate *) aDate {
    NSTimeInterval timeIntervalSinceDate = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(timeIntervalSinceDate / SECONDS_IN_DAY);
}

- (NSInteger)daysBeforeDate_Ext:(NSDate *) aDate {
    NSTimeInterval timeIntervalSinceDate = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(timeIntervalSinceDate / SECONDS_IN_DAY);
}

- (NSInteger)monthsAfterDate_Ext:(NSDate *) aDate {
    NSInteger result = (self.gregorianYear_Ext - aDate.gregorianYear_Ext) * 12 + (self.month_Ext - aDate.month_Ext);

    if (result == 0) {
        return 0;
    } else if (0 < result) {
        if (aDate.day_Ext < self.day_Ext || (aDate.day_Ext == self.day_Ext && [self timeIntervalIgnoringDay:aDate] <= 0)) {
            return result;
        } else {
            return result - 1;
        }
    } else {
        if (self.day_Ext < aDate.day_Ext || (self.day_Ext == aDate.day_Ext && 0 <= [self timeIntervalIgnoringDay:aDate])) {
            return result;
        } else {
            return result + 1;
        }
    }
}

- (NSInteger)monthsBeforeDate_Ext:(NSDate *) aDate {
    return -[self monthsAfterDate_Ext:aDate];
}

- (NSTimeInterval)timeIntervalIgnoringDay:(NSDate *) aDate {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    enum NSCalendarUnit unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:aDate];
    NSDateComponents *components1 = [calendar components:unitFlags fromDate:self];
    return [[calendar dateFromComponents:components] timeIntervalSinceDate:[calendar dateFromComponents:components1]];
}

- (NSInteger)distanceInDaysToDate_Ext:(NSDate *) aDate {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *dateComponents = [calendar
        components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    return [dateComponents day];
}
#pragma mark - Decomposing dates
// NSDate-Utilities API is broken?
- (NSInteger)nearestHour_Ext {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSRange minuteRange = [calendar rangeOfUnit:NSCalendarUnitMinute inUnit:NSCalendarUnitHour forDate:self];
    // always 30...
    NSInteger halfMinuteInHour = minuteRange.length / 2;
    NSInteger currentMinute = self.minute_Ext;
    if (currentMinute < halfMinuteInHour) {
        return self.hour_Ext;
    } else {
        NSDate *anHourLater = [self dateByAddingHours_Ext:1];
        return [anHourLater hour_Ext];
    }
}

- (NSInteger)hour_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitHour fromDate:self];
    return [components hour];
}

- (NSInteger)minute_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMinute fromDate:self];
    return [components minute];
}

- (NSInteger)seconds_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitSecond fromDate:self];
    return [components second];
}

- (NSInteger)day_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)month_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)weekOfYear_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self];
    return [components weekOfYear];
}
- (NSInteger)weekOfMonth_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
    return [components weekOfMonth];
}

- (NSInteger)weekday_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    return [components weekday];
}

// http://stackoverflow.com/questions/11681815/current-week-start-and-end-date
- (NSInteger)firstDayOfWeekday_Ext {
    NSDate *startOfTheWeek;
    NSTimeInterval interval;
    [[NSDate AZ_currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfYear
                                 startDate:&startOfTheWeek
                                 interval:&interval
                                 forDate:self];
    return [startOfTheWeek day_Ext];
}

- (NSInteger)lastDayOfWeekday_Ext {
    return [self firstDayOfWeekday_Ext] + (DAYS_IN_WEEK - 1);
}

- (NSInteger)nthWeekday_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self];
    return [components weekdayOrdinal];
}

- (NSInteger)year_Ext {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return [components year];
}
- (NSInteger)gregorianYear_Ext {
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:self];
    return [components year];
}

@end
