//
//  DateManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject

+ (id)sharedManager;

- (NSDateFormatter *)dateFormatter;
- (NSDateFormatter *)presentedDateFormatter;
- (NSDateFormatter *)yearFormatter;
- (NSDateFormatter *)numberDateFormatter;
- (NSDateFormatter *)postFormatter;
- (NSDateFormatter *)reminderFormatter;
- (NSDateFormatter *)revertReminderFormatter;
- (NSString*)currentDate;
- (NSDate*)dateTimeFromString:(NSString*)dateTime;

@end
