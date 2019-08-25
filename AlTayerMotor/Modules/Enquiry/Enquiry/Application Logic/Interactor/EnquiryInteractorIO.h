//
//  EnquiryInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUser;
@class MEnquiryRequest;

@protocol EnquiryInteractorInput <NSObject>
- (void)findBrands;
- (void)findPreownedBrands;
- (void)findModelsByBrand:(NSInteger)brandId;
- (void)findPreownedModelsByBrand:(NSInteger)brandId;
- (void)findUserInfo;
- (void)postEnquiry:(MEnquiryRequest *)request;
- (void)findEnquiries;
@end

@protocol EnquiryInteractorOutput <NSObject>
- (void)foundBrands:(NSArray *)brands;
- (void)foundPreownedBrands:(NSArray *)brands;
- (void)foundModels:(NSArray *)models;
- (void)foundPreownedModels:(NSArray *)models;
- (void)foundUserInfo:(MUser *)user;
- (void)foundEnquiries:(NSArray *)enquiries andVehicleEnquiries:(NSArray *)vehicleEnquiries;

- (void)postEnquiryFailed;
- (void)postEnquirySuccessWithRequest:(MEnquiryRequest *)request;
@end
