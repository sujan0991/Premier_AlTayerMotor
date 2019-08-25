//
//  MVehicle.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MVehicle.h"
#import "NSString+Utils.h"

@implementation MVehicle

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.brandId = [dict[@"brand_id"] integerValue];
        self.currency = dict[@"currency"];
        self.desc = dict[@"description"];
        self.engine = dict[@"engine"];
        self.fuelType = dict[@"fuel_type"];
        self.Id = [dict[@"id"] integerValue];
        self.image = dict[@"image"];
        self.images = dict[@"images"];
        self.model = dict[@"model"];
        self.price = [dict[@"price"] integerValue];
        self.seat = [dict[@"seats"] integerValue];
        self.category = dict[@"vehicle_category"];
        self.year = [dict[@"year"] integerValue];
        self.mileage = [dict[@"mileage"] integerValue];
        self.trim = dict[@"trim"];
        self.color = dict[@"color"];
        self.modelId = [dict[@"model_id"] integerValue];
    }
    
    return self;
}

- (NSString *)imageLink
{
    if ([self isValidString:self.image] && self.image.length > 0) {
        return [self.image toImageLink];
    } else if (self.images && self.images.count > 0) {
        return [self.images[0] toImageLink];
    }
    return nil;
}

- (NSString *)getCurrency
{
    if ([self isValidString:self.currency] && self.currency.length > 0 && ![self.currency isEqualToString:@"AED"]) {
        return self.currency;
    }
    
    return LOCALIZED(@"TEXT AED");
}

@end
