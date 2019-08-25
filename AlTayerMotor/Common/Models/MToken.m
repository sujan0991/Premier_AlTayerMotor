//
//  MToken.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MToken.h"

@implementation MToken

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _accessToken = dict[@"access_token"];
        _expiresIn = [dict[@"expires_in"] integerValue];
        _bearer = dict[@"token_type"];
        _logedInTime = [[NSDate date] timeIntervalSince1970];
    }
    
    return self;
}

- (BOOL)needUpdate
{
    CGFloat currentDate = [[NSDate date] timeIntervalSince1970];
    DLog(@"\n%f\n%f", currentDate, (_logedInTime + _expiresIn - 10));
    
    return currentDate > (_logedInTime + _expiresIn - 10);
}

@end