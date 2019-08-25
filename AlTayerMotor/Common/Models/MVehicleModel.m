//
//  MVehicleModel.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/29/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MVehicleModel.h"
#import "VehicleModel.h"
#import "NSString+Utils.h"

@implementation MVehicleModel

- (instancetype)initWithId:(NSInteger)Id
               withBrandId:(NSInteger)brandId
                 withModel:(NSString *)model
               withModelAR:(NSString *)modelAR
             withModelYear:(NSNumber *)modelYear
                  withType:(NSString *)type
                 withImage:(NSString *)image
{
    if (self = [super init]) {
        self.id = Id;
        self.brandId = brandId;
        self.model = model;
        self.modelAR = modelAR;
        self.modelYear = [modelYear integerValue];
        self.type = type;
        self.image = image;
    }
    
    return self;
}

- (instancetype)initWithVehicleModel:(VehicleModel *)vehicleModel
{
    return [self initWithId:[vehicleModel.id integerValue]
                withBrandId:[vehicleModel.brand_id integerValue]
                  withModel:vehicleModel.model
                withModelAR:vehicleModel.model_ar
              withModelYear:vehicleModel.model_year
                   withType:vehicleModel.type
                  withImage:vehicleModel.image];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.id = [dict[@"id"] integerValue];
        self.brandId = [dict[@"brand_id"] integerValue];
        self.model = dict[@"model"];
        if (dict[@"model_ar"] && ![dict[@"model_ar"] isEqual:[NSNull null]]) {
            self.modelAR = dict[@"model_ar"];
        } else {
            self.modelAR = @"";
        }
        self.type = dict[@"vehicle_category"];
        if ([self.type isEqual:[NSNull null]] || [self.type isInvalid]) {
            self.type = @"other";
        }
        self.image = dict[@"image"];
        DLog(@"%@", dict[@"model_ar"]);
    }
    
    return self;
}

- (NSString *)model
{
    if (!_modelAR || [_modelAR isEqual:[NSNull null]] || _modelAR.length == 0) {
        return _model;
    }
    
    return  [ATMGlobal isEnglish] ? _model : _modelAR;
}

@end
