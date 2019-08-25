//
//  VehiclesWireframe.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VehiclesFilterDisplayData;
@class MPreownedBrand;
@class MVehicle;

@interface VehiclesWireframe : NSObject

- (void)presentVehiclesInterfaceInBrand:(MPreownedBrand *)brand
                           inNavigation:(UINavigationController *)navController;
- (void)presentFilterVehiclesWithData:(VehiclesFilterDisplayData *)data
                         inNavigation:(UINavigationController *)navController;
- (void)presentDetailsInterfaceWithData:(MVehicle *)vehicle
                           inNavigation:(UINavigationController *)navigationController;
- (void)presentPeekOffersInterfaceWithData:(NSArray*)offers
                           withViewedIndex:(NSInteger)index
                              inNavigation:(UINavigationController *)navController;
@end
