//
//  EnquiryModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEnquiryRequest;

@protocol EnquiryModuleInterface <NSObject>

- (void)findBrands;
- (void)findPreownedBrands;
- (void)findModelsByBrand:(NSInteger)brandId;
- (void)findPreownedModelsByBrand:(NSInteger)brandId;
- (void)findUserInfo;
- (void)findEnquiries;

- (void)showEnquirySelectionAlert:(NSArray *)enquiries;
- (void)showTypeSelectionAlert:(NSArray *)vehicleEnquiries;
- (void)showBrandSelectionAlert:(NSArray *)brands;
- (void)showPreownedBrandSelectionAlert:(NSArray *)brands;
- (void)showModelSelectionAlert:(NSArray *)models;
- (void)showPreownedModelSelectionAlert:(NSArray *)models;

- (void)sendEnquiryRequest:(MEnquiryRequest *)request;
@end
