//
//  VehiclesDataManager.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesDataManager.h"
#import "CoreDataStore.h"

@implementation VehiclesDataManager

- (NSArray*)loadAllVehicleModelsInBrandId:(NSInteger)brandId
{
    return [self.dataStore fetchPreownedVehicleModelsByBrand:brandId];
}

- (MPreownedBrand *)getBrandById:(NSInteger)brandId
{
    return [self.dataStore getPreownedBrandById:brandId];
}

@end
