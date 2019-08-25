//
//  EditRegisteredVehicleInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;

@protocol EditRegisteredVehicleInteractorInput <NSObject>
-(void)findBrands;
-(void)findVehicleModelsByBrand:(NSInteger)brandId;
-(BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;
-(void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle
                  forOldNumber:(NSString *)registrationNumber;
@end

@protocol EditRegisteredVehicleInteractorOutput <NSObject>
- (void)foundBrands:(NSArray *)brands;
- (void)foundVehicleModels:(NSArray *)vehicleModels;
- (void)completeUpdatingRegisteredVehicle;
@end
