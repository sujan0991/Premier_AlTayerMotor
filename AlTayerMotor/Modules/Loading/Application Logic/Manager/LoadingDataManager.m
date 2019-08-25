//
//  LoadingDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LoadingDataManager.h"
#import "CoreDataStore.h"
#import "MBrand.h"
#import "MCity.h"

@implementation LoadingDataManager

- (void)syncBrands:(NSArray *)brands
{
    if (brands) {
        [self.dataStore deleteAllBrands];
        [brands enumerateObjectsUsingBlock:^(MBrand *brand, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataStore syncBrand:brand];
        }];
    }
}

- (void)syncPreownedBrands:(NSArray *)brands
{
    if (brands) {
        [self.dataStore deleteAllPreownedBrands];
        [brands enumerateObjectsUsingBlock:^(MPreownedBrand *brand, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataStore syncPreownedBrand:brand];
        }];
    }
}

- (void)syncCities:(NSArray *)cities
{
    if (cities) {
        [self.dataStore deleteAllCities];
        [self.dataStore insertCities:cities];
    }
}

- (void)syncDrivingExperiences:(NSArray *)drivingExperiences
{
    if (drivingExperiences) {
        [self.dataStore deleteAllDrivingExperiences];
        [self.dataStore insertDrivingExperiences:drivingExperiences];
    }
}

- (void)syncLocations:(NSArray *)locations
{
    if (locations) {
        [self.dataStore deleteAllLocations];
        [self.dataStore insertLocations:locations];
    }
}

- (void)syncGlobalSettings:(NSArray *)settings
{
    if (settings) {
        [self.dataStore deleteAllGlobalSettings];
        [self.dataStore insertGlobalSettings:settings];
    }
}

@end
