//
//  MResponse.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MResponse.h"
#import "DateManager.h"

@implementation MResponse

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _message = dict[@"message"];
        _status = [dict[@"status"] integerValue];
        if (dict[@"modified_date"]) {
            _responseDate = [[DateManager sharedManager]
                             dateTimeFromString:dict[@"modified_date"]];
        }
    }
    
    return self;
}

@end

@implementation MPayload
@end

@implementation MPayloadToken
@end

@implementation MPayloadResult
@end

@implementation MPayloadBrandsList
@end

@implementation MPayloadVehiclesList
@end

@implementation MPayloadCitiesList
@end

@implementation MPayloadDrivingExperiencesList
@end

@implementation MPayloadLocationsList
@end

@implementation MPayloadGlobalSettingsList
@end

@implementation MPayloadOffersList
@end