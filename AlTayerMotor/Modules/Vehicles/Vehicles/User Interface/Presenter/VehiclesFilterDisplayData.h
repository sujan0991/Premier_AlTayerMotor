//
//  VehiclesFilterDisplayData.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VehicleModelsDisplayData;
@class MPreownedVehicleModel;

@interface VehiclesFilterDisplayData : NSObject

@property (nonatomic, assign) NSInteger upperPrice;
@property (nonatomic, assign) NSInteger lowerPrice;

@property (nonatomic, assign) NSInteger upperMileage;
@property (nonatomic, assign) NSInteger lowerMileage;

@property (nonatomic, assign) NSInteger upperYear;
@property (nonatomic, assign) NSInteger lowerYear;

@property (nonatomic, strong) MPreownedVehicleModel *selectedModel;

@property (nonatomic, strong) VehicleModelsDisplayData *modelsData;
@property (nonatomic, assign) BOOL isNewCar;

@property (nonatomic, assign) BOOL filterChanged;

@property (nonatomic, assign) NSInteger oldestYear;

@end
