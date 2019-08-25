//
//  LoadingDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;

@interface LoadingDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (void)syncBrands:(NSArray *)brands;
- (void)syncPreownedBrands:(NSArray *)brands;
- (void)syncCities:(NSArray *)cities;
- (void)syncDrivingExperiences:(NSArray *)drivingExperiences;
- (void)syncLocations:(NSArray *)locations;
- (void)syncGlobalSettings:(NSArray *)settings;

@end
