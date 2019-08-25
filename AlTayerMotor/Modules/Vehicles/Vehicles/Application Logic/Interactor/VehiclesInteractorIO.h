//
//  VehicleInteractorIO.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VehiclesFilterDisplayData;

@protocol VehiclesInteractorInput <NSObject>
- (void)loadAllVehicleModelsInBrandId:(NSInteger)brandId;
- (void)getVehiclesInBrand:(NSInteger)brandId
                    inPage:(NSInteger)page
                withFilter:(VehiclesFilterDisplayData *)data;
- (void)getBrandOffers:(NSInteger)brandId;
@end


@protocol VehiclesInteractorOutput <NSObject>
- (void)didLoadVehicleModels:(NSArray*)vehicleModels;
- (void)didGetVehicles:(NSArray*)vehicles;
- (void)didGetVehiclesError:(NSError *)error;
- (void)didGetOffers:(NSArray*)offers;
- (void)didGetOffersError:(NSError *)error;
@end
