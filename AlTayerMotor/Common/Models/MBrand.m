//
//  MBrand.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBrand.h"
#import "MVehicleModel.h"

@implementation MBrand

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _id = [dict[@"id"] integerValue];
        _logo = dict[@"logo"];
        _name = dict[@"name"];
        _url = dict[@"brand_url"];
        _nameAR = dict[@"name_ar"];
        _roadsideAssistance = dict[@"roadside_assistance"];
        _vehicleModels = [@[] mutableCopy];
        
        NSArray* vehicleModelsArr = dict[@"vehicle_models"];
        if (vehicleModelsArr && ![vehicleModelsArr isEqual:[NSNull null]]) {
            [vehicleModelsArr enumerateObjectsUsingBlock:^(NSDictionary *modelDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MVehicleModel *model = [[MVehicleModel alloc] initWithDict:modelDict];
                [_vehicleModels addObject:model];
            }];
        }
    }
    
    return self;
}

- (instancetype)initWithId:(NSInteger)Id 
                  withName:(NSString*)name
                withNameAR:(NSString*)nameAR
                  withLogo:(NSString *)logo
                   withUrl:(NSString *)url
              withRoadside:(NSString *)roadside
{
    MBrand *brand = [MBrand new];
    brand.id = Id;
    brand.name = name;
    brand.nameAR = nameAR;
    brand.logo = logo;
    brand.url = url;
    brand.roadsideAssistance = roadside;
    
    return brand;
}

- (NSString *)name
{
    return  [ATMGlobal isEnglish] ? _name : _nameAR;
}

@end