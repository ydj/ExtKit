//  NSDate+ExtensionExt.h
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



#import <Foundation/Foundation.h>

@interface NSDate (ExtensionExt)

/**
 * 时间间隔几个月的时间
 * @param date 开始时间
 * @param month 间隔月数，正数是date之后的时间，负数是date之前的时间
 * @return 计算后的时间
 */
+ (NSDate *)dateWithIntervalMonthFromDate_Ext:(NSDate *)date intervalMonth:(NSInteger)month;
/**
 * 时间间隔几个月的时间
 * @param month 间隔月数，正数是之后的时间，负数是之前的时间
 * @return 计算后的时间
 */
- (NSDate *)dateWithIntervalMonth_Ext:(NSInteger)month;

/**
 * 间隔几天的时间
 * @param data 开始时间
 * @param day 间隔天数  正数是之后的时间，负数是之前的时间
 * @return 计算的时间
 */
+ (NSDate *)dateWithIntervalDayFromDate_Ext:(NSDate *)date intervalDay:(NSInteger)day;
/**
 * 间隔几天的时间
 * @param day 间隔天数  正数是之后的时间，负数是之前的时间
 * @return 计算的时间
 */
- (NSDate *)dateWithIntervalDay_Ext:(NSInteger)day;


#pragma mark - Relative dates from the current date
/**
 * 得到明天的时间
 *
 * @return 明天的时间
 */
+ (NSDate *)dateTomorrow_Ext;
/**
 * 得到昨天的时间
 *
 * @return 昨天的时间
 */
+ (NSDate *)dateYesterday_Ext;

/**
 * 当前时间之后几天的一个时间
 * @param dDays 间隔的天数
 * @return 得到的时间
 */
+ (NSDate *)dateWithDaysFromNow_Ext:(NSInteger) dDays;

/**
 * 当前时间之前几天的一个时间
 * @param dDays 间隔的天数
 * @return 得到的时间
 */
+ (NSDate *)dateWithDaysBeforeNow_Ext:(NSInteger) dDays;

/**
 * 当前时间之后几个小时的时间
 * @param dHours 间隔小时数
 * @return 得到的时间
 */
+ (NSDate *)dateWithHoursFromNow_Ext:(NSInteger) dHours;
/**
 * 当前时间之前几个小时的时间
 * @param dHours 间隔小时数
 * @return 得到的时间
 */
+ (NSDate *)dateWithHoursBeforeNow_Ext:(NSInteger) dHours;

/**
 * 当前时间之前的几分钟的时间
 * @param dMinutes 间隔的分钟数
 * @return 得到的时间
 */
+ (NSDate *)dateWithMinutesFromNow_Ext:(NSInteger) dMinutes;
/**
 * 当前时间之后的几分钟的时间
 * @param dMinutes 间隔的分钟数
 * @return 得到的时间
 */
+ (NSDate *)dateWithMinutesBeforeNow_Ext:(NSInteger) dMinutes;

#pragma mark - Comparing dates
/**
 * 是否是同一天，年月日相同
 * @param otherDate 另外要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isEqualToDateIgnoringTime_Ext:(NSDate *) otherDate;
/**
 * 是否今天
 *
 * @return YES 是，NO 否
 */
- (BOOL)isToday_Ext;
/**
 * 是否明天
 *
 * @return YES 是，NO 否
 */
- (BOOL)isTomorrow_Ext;
/**
 * 是否昨天
 *
 * @return YES 是，NO 否
 */
- (BOOL)isYesterday_Ext;
/**
 * 是否在同一周
 * @param otherDate 另外要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isSameWeekAsDate_Ext:(NSDate *) aDate;
/**
 * 是否在本周
 *
 * @return YES 是，NO 否
 */
- (BOOL)isThisWeek_Ext;
/**
 * 是否在下一周
 *
 * @return YES 是，NO 否
 */
- (BOOL)isNextWeek_Ext;
/**
 * 是否是最后一周
 *
 * @return YES 是，NO 否
 */
- (BOOL)isLastWeek_Ext;
/**
 * 是否是同一个月，月相同
 * @param aDate 要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isSameMonthAsDate_Ext:(NSDate *) aDate;
/**
 * 是否是本月
 *
 * @return YES 是，NO 否
 */
- (BOOL)isThisMonth_Ext;
/**
 * 是否是同一年
 * @param aDate 要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isSameYearAsDate_Ext:(NSDate *) aDate;
/**
 * 是否是当前的年
 *
 * @return YES 是，NO 否
 */
- (BOOL)isThisYear_Ext;
/**
 * 是否是下一年
 *
 * @return YES 是，NO 否
 */
- (BOOL)isNextYear_Ext;
/**
 * 是否是上一年
 *
 * @return YES 是，NO 否
 */
- (BOOL)isLastYear_Ext;

/**
 * 是否比这个时间早
 * @param aDate 要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isEarlierThanDate_Ext:(NSDate *) aDate;
/**
 * 是否比这个时间晚
 * @param aDate 要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isLaterThanDate_Ext:(NSDate *) aDate;
/**
 * 是否比这个时间早或者相同
 * @param aDate 要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isEarlierThanOrEqualDate_Ext:(NSDate *) aDate;
/**
 * 是否比这个时间晚或者相同
 * @param aDate 要比较的时间
 * @return YES 是，NO 否
 */
- (BOOL)isLaterThanOrEqualDate_Ext:(NSDate *) aDate;
/**
 * 是否是未来的时间
 *
 * @return YES 是，NO 否
 */
- (BOOL)isInFuture_Ext;
/**
 * 是否是过去的时间
 *
 * @return YES 是，NO 否
 */
- (BOOL)isInPast_Ext;

#pragma mark - Date roles
/**
 * 是否是工作时间(周一至周五)
 *
 * @return YES 是，NO 否
 */
- (BOOL)isTypicallyWorkday_Ext;
/**
 * 是否是周末时间（周六\周日）
 *
 * @return YES 是，NO 否
 */
- (BOOL)isTypicallyWeekend_Ext;

#pragma mark - Adjusting dates
- (NSDate *)dateByAddingYears_Ext:(NSInteger) dYears;

- (NSDate *)dateBySubtractingYears_Ext:(NSInteger) dYears;

- (NSDate *)dateByAddingMonths_Ext:(NSInteger) dMonths;

- (NSDate *)dateBySubtractingMonths_Ext:(NSInteger) dMonths;

- (NSDate *)dateByAddingDays_Ext:(NSInteger) dDays;

- (NSDate *)dateBySubtractingDays_Ext:(NSInteger) dDays;

- (NSDate *)dateByAddingHours_Ext:(NSInteger) dHours;

- (NSDate *)dateBySubtractingHours_Ext:(NSInteger) dHours;

- (NSDate *)dateByAddingMinutes_Ext:(NSInteger) dMinutes;

- (NSDate *)dateBySubtractingMinutes_Ext:(NSInteger) dMinutes;

- (NSDate *)dateAtStartOfDay_Ext;

- (NSDate *)dateAtEndOfDay_Ext;

- (NSDate *)dateAtStartOfWeek_Ext;

- (NSDate *)dateAtEndOfWeek_Ext;

- (NSDate *)dateAtStartOfMonth_Ext;

- (NSDate *)dateAtEndOfMonth_Ext;

- (NSDate *)dateAtStartOfYear_Ext;

- (NSDate *)dateAtEndOfYear_Ext;

#pragma mark - Retrieving intervals

- (NSInteger)minutesAfterDate_Ext:(NSDate *) aDate;

- (NSInteger)minutesBeforeDate_Ext:(NSDate *) aDate;

- (NSInteger)hoursAfterDate_Ext:(NSDate *) aDate;

- (NSInteger)hoursBeforeDate_Ext:(NSDate *) aDate;

- (NSInteger)daysAfterDate_Ext:(NSDate *) aDate;

- (NSInteger)daysBeforeDate_Ext:(NSDate *) aDate;

- (NSInteger)monthsAfterDate_Ext:(NSDate *) aDate;

- (NSInteger)monthsBeforeDate_Ext:(NSDate *) aDate;

/**
 * 两个时间间隔的天数
 * @param aDate 要比较的时间
 * @return 天数
 */
- (NSInteger)distanceInDaysToDate_Ext:(NSDate *) aDate;

#pragma mark - Decomposing dates
/**
* return nearest hour
*/
@property(readonly) NSInteger nearestHour_Ext;
@property(readonly) NSInteger hour_Ext;
@property(readonly) NSInteger minute_Ext;
@property(readonly) NSInteger seconds_Ext;
@property(readonly) NSInteger day_Ext;
@property(readonly) NSInteger month_Ext;
@property(readonly) NSInteger weekOfYear_Ext;
@property(readonly) NSInteger weekOfMonth_Ext;
//  in the Gregorian calendar, n is 7 and Sunday is represented by 1.
@property(readonly) NSInteger weekday_Ext;
@property(readonly) NSInteger firstDayOfWeekday_Ext;
@property(readonly) NSInteger lastDayOfWeekday_Ext;
// e.g. 2nd Tuesday of the month == 2
@property(readonly) NSInteger nthWeekday_Ext;
@property(readonly) NSInteger year_Ext;
@property(readonly) NSInteger gregorianYear_Ext;
@end
