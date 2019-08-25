//
//  MResponse.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"
#import "MBrand.h"
#import "MCity.h"
#import "MVehicle.h"
#import "MToken.h"
#import "MLocation.h"

@interface MPayload : MBase
@end

@interface MPayloadToken : MPayload
@property(strong, nonatomic) MToken *token;
@end

@interface MPayloadResult : MPayload
@property(assign, nonatomic) BOOL success;
@end

@interface MPayloadBrandsList : MPayload
@property(strong, nonatomic) NSArray *brands;
@end

@interface MPayloadVehiclesList : MPayload
@property(strong, nonatomic) NSArray *vehicles;
@end

@interface MPayloadCitiesList : MPayload
@property(strong, nonatomic) NSArray *cities;
@end

@interface MPayloadDrivingExperiencesList : MPayload
@property(strong, nonatomic) NSArray *drivingExperiences;
@end

@interface MPayloadLocationsList : MPayload
@property(strong, nonatomic) NSArray *locations;
@end

@interface MPayloadGlobalSettingsList : MPayload
@property(strong, nonatomic) NSArray *globalSettings;
@end

@interface MPayloadOffersList : MPayload
@property(strong, nonatomic) NSArray *offers;
@end

@interface MResponse : MBase

@property (assign, nonatomic) NSInteger status;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) MPayload *payload;
@property (strong, nonatomic) NSDate *responseDate;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
