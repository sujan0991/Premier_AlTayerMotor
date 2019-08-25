//
//  VehiclesViewInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VehiclesDisplayData;
@class VehicleModelsDisplayData;
@class VehiclesFilterDisplayData;
@class BrandOffersDisplayData;
@class MPreownedBrand;

@protocol VehiclesViewInterface <NSObject>

- (void)updateVehicleModelsData:(VehicleModelsDisplayData *)data;
- (VehiclesDisplayData *)getVehiclesData;
- (NSInteger)getCurrentBrandId;
- (VehiclesFilterDisplayData *)getFilterData;
- (void)reloadVehiclesData;
- (MPreownedBrand *)getCurrentBrand;
- (BrandOffersDisplayData *)getOffersData;
@end
