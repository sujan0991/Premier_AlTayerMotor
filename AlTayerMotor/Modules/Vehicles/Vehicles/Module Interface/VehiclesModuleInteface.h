//
//  VehiclesModuleInteface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VehiclesFilterDisplayData;
@class MVehicle;

@protocol VehiclesModuleInteface <NSObject>
- (void)presentFilterInterfaceWithData:(VehiclesFilterDisplayData *)data;
- (void)presentDetailsInterfaceWithData:(MVehicle *)vehicle;
- (void)presentOffersInterfaceWithData:(NSArray*)offers
                       withViewedIndex:(NSInteger)index;
- (void)loadAllVehicleModelsInBrandId:(NSInteger)brandId;
- (void)getVehicles;
- (void)getOffers;
- (void)resetHasLoadMore;
- (BOOL)isLoadingAtFirstPage;

@end
