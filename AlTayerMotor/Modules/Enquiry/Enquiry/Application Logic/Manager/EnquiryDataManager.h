//
//  EnquiryDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MUser;

@interface EnquiryDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findCities;
- (NSArray *)findBrands;
- (NSArray *)findPreownedBrands;
- (NSArray *)findModelsByBrand:(NSInteger)brandId;
- (NSArray *)findPreownedModelsByBrand:(NSInteger)brandId;
- (MUser *)findUserInfo;
- (NSArray *)findEnquiries;
- (NSArray *)findVehicleEnquiries;

@end
