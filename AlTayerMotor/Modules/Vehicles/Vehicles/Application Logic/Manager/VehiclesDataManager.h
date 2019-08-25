//
//  VehiclesDataManager.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MPreownedBrand;
@interface VehiclesDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray*)loadAllVehicleModelsInBrandId:(NSInteger)brandId;
- (MPreownedBrand *)getBrandById:(NSInteger)brandId;

@end