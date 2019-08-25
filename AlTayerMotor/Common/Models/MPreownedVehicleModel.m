//
//  MPreownedVehicleModel.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MPreownedVehicleModel.h"
#import "PreownedVehicleModel.h"
#import "NSString+Utils.h"

@implementation MPreownedVehicleModel

- (instancetype)initWithId:(NSInteger)Id
               withBrandId:(NSInteger)brandId
                 withModel:(NSString *)model
             withModelYear:(NSNumber *)modelYear
                  withType:(NSString *)type
                 withImage:(NSString *)image
{
    if (self = [super init]) {
        self.id = Id;
        self.brandId = brandId;
        self.model = model;
        self.modelYear = [modelYear integerValue];
        self.type = type;
        self.image = image;
    }
    
    return self;
}

- (instancetype)initWithVehicleModel:(PreownedVehicleModel *)vehicleModel
{
    return [self initWithId:[vehicleModel.id integerValue]
                withBrandId:[vehicleModel.brand_id integerValue]
                  withModel:vehicleModel.model
              withModelYear:vehicleModel.model_year
                   withType:vehicleModel.type
                  withImage:vehicleModel.image];
}

- (instancetype)initWithDict:(NSDictionary *)dict andCategory:(NSString*)category
{
    if (self = [super init]) {
        self.id = [dict[@"id"] integerValue];
        self.brandId = [dict[@"brand_id"] integerValue];
        self.model = dict[@"model"];
        self.type = category;
        if ([self.type isEqual:[NSNull null]] || [self.type isInvalid]) {
            self.type = @"other";
        }
        self.image = dict[@"image"];
    }
    
    return self;
}

@end
