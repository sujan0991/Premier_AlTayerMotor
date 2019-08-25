//
//  MUser.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MUser.h"
#import "User.h"
#import "MCity.h"

@implementation MUser

- (instancetype)initWithUser:(User *)user andCity:(MCity *)city
{
    if (self = [super init]) {
        _id = [user.id integerValue];
        _firstName = user.first_name;
        _lastName = user.last_name;
        _phoneCode = user.phone_code;
        _phoneNumber = user.phone_number;
        _city = city;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@", _firstName, _lastName, _phoneCode, _phoneNumber, _city.key];
}

@end
