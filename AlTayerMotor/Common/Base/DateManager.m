//
//  DateManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "DateManager.h"

@interface DateManager()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDateFormatter *yearFormatter;
@property (strong, nonatomic) NSDateFormatter *dateTimeFormatter;
@property (strong, nonatomic) NSDateFormatter *presentedDateFormatter;
@property (strong, nonatomic) NSDateFormatter *numberDateFormatter;
@property (strong, nonatomic) NSDateFormatter *postFormatter;
@property (strong, nonatomic) NSDateFormatter *reminderFormatter;
@property (strong, nonatomic) NSDateFormatter *revertReminderFormatter;

@end

@implementation DateManager

+ (id)sharedManager {
    static DateManager *sharedDateManager = nil;
    @synchronized(self) {
        if (sharedDateManager == nil)
            sharedDateManager = [[self alloc] init];
    }
    return sharedDateManager;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
    
    return _dateFormatter;
}

- (NSDateFormatter *)yearFormatter
{
    if (!_yearFormatter) {
        _yearFormatter = [[NSDateFormatter alloc] init];
        [_yearFormatter setDateFormat:@"yyyy"];
    }
    
    return _yearFormatter;
}

- (NSDateFormatter *)dateTimeFormatter
{
    if (!_dateTimeFormatter) {
        _dateTimeFormatter = [[NSDateFormatter alloc] init];
        [_dateTimeFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [_dateTimeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
    
    return _dateTimeFormatter;
}

- (NSDateFormatter *)numberDateFormatter
{
    if (!_numberDateFormatter) {
        _numberDateFormatter = [[NSDateFormatter alloc] init];
        [_numberDateFormatter setDateFormat:@"yyyyMMdd"];
    }
    
    return _numberDateFormatter;
}

- (NSDateFormatter *)presentedDateFormatter
{
    if (!_presentedDateFormatter) {
        _presentedDateFormatter = [[NSDateFormatter alloc] init];
        [_presentedDateFormatter setDateFormat:@"dd MMM yyyy"];
    }
    
    return _presentedDateFormatter;
}

- (NSDateFormatter *)postFormatter
{
    if (!_postFormatter) {
        _postFormatter = [[NSDateFormatter alloc] init];
        [_postFormatter setDateFormat:@"MM/dd/yyyy"];
    }
    
    return _postFormatter;
}

- (NSDateFormatter *)reminderFormatter
{
    if (!_reminderFormatter) {
        _reminderFormatter = [[NSDateFormatter alloc] init];
        [_reminderFormatter setDateFormat:@"dd/MM/yyyy"];
    }
    
    return _reminderFormatter;
}

- (NSDateFormatter *)revertReminderFormatter
{
    if (!_revertReminderFormatter) {
        _revertReminderFormatter = [[NSDateFormatter alloc] init];
        [_revertReminderFormatter setDateFormat:@"yyyy/MM/dd"];
    }
    
    return _revertReminderFormatter;
}

- (NSString*)currentDate
{
    return [_dateFormatter stringFromDate:[NSDate date]];
}

- (NSDate*)dateTimeFromString:(NSString*)dateTime
{
    return [_dateTimeFormatter dateFromString:dateTime];
}

@end
