//
//  MRegisterCar.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class MBrand;
@class MVehicleModel;

@interface MRegisteredVehicle : MBase

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger brandId;
@property (nullable, nonatomic, strong) MBrand *brand;
@property (nullable, strong, nonatomic) NSString *otherBrand;
@property (nullable, strong, nonatomic) NSString *otherModel;
@property (nonatomic, assign) NSInteger modelId;
@property (nullable, nonatomic, strong) MVehicleModel *model;
@property (nonatomic, assign) NSInteger year;
@property (nullable, nonatomic, strong) NSString *registrationNumber;
@property (nullable, nonatomic, strong) NSString *registrationExpiry;

- (BOOL)hasChanged:( MRegisteredVehicle* _Nullable)newInfo;
@end
