//
//  EnquiryViewInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBrand;
@class MPreownedBrand;
@class MVehicleModel;
@class MPreownedVehicleModel;
@class MPreownedBrand;
@class MUser;
@class MGlobalSetting;

@protocol EnquiryViewInterface <NSObject>

- (void)updateBrands:(NSArray *)brands;
- (void)updatePreownedBrands:(NSArray *)brands;
- (void)updateModels:(NSArray *)models;
- (void)updatePreownedModels:(NSArray *)models;
- (void)updateUserInfo:(MUser *)user;
- (void)updateEnquiries:(NSArray *)enquiries andVehicleEnquiries:(NSArray *)vehicleEnquiries;

- (void)didSelectEnquiry:(MGlobalSetting*)enquiry;
- (void)didSelectType:(MGlobalSetting*)type;
- (void)didSelectBrand:(MBrand *)brand;
- (void)didSelectPreownedBrand:(MPreownedBrand *)brand;
- (void)didSelectModel:(MVehicleModel *)model;
- (void)didSelectPreownedModel:(MPreownedVehicleModel *)model;

- (void)didSetDefaultBrand:(NSInteger)brandId andModel:(NSInteger)modelId;

@end
