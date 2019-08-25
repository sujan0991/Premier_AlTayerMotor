//
//  GTMHelper.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/6/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTMHelper : NSObject

+ (instancetype)sharedInstance;
- (void)startApplicationEvent;
- (void)logEvent:(NSString *)event;
- (void)logEvent:(NSString *)event inScreenName:(NSString *)screenName;
- (void)logEvent:(NSString *)event inScreenName:(NSString *)screenName withAdditionalData:(NSDictionary *)data;

@end
