//
//  HttpsManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VehiclesFilterDisplayData;
@class MServiceRequest;
@class MBookingTestRequest;
@class MInsuranceRequest;
@class MEnquiryRequest;

typedef void (^CompletionBlock)(id, NSError *);

@interface HttpsManager : NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate>

+ (id)sharedManager;

- (void)generateTokenWithCompletion:(CompletionBlock)completion;
- (void)getBrandsSince:(NSString *)date
        withCompletion:(CompletionBlock)completion;
- (void)getPreownedBrandsSince:(NSString *)date
                withCompletion:(CompletionBlock)completion;
- (void)getVehiclesInPage:(NSInteger)page
                  inBrand:(NSInteger)brandId
               withFilter:(VehiclesFilterDisplayData *)filter
           withCompletion:(CompletionBlock)completion;
- (void)getCitiesWithCompletion:(CompletionBlock)completion;
- (void)getGlobalSettingsWithCompletion:(CompletionBlock)completion;
- (void)getLocationsWithCompletion:(CompletionBlock)completion;
- (void)postBookService:(MServiceRequest *)request
         withCompletion:(CompletionBlock)completion;
- (void)postBookTest:(MBookingTestRequest *)request
      withCompletion:(CompletionBlock)completion;
- (void)postInsuranceRequest:(MInsuranceRequest *)request
              withCompletion:(CompletionBlock)completion;
- (void)postEnquiryRequest:(MEnquiryRequest *)request
              withCompletion:(CompletionBlock)completion;
- (void)getDrivingExperiencesWithCompletion:(CompletionBlock)completion;
- (void)getBrandOffers:(NSInteger)brandId
        withCompletion:(CompletionBlock)completion;
- (void)getLatestOffersWithCompletion:(CompletionBlock)completion;
- (void)getOffersWithCompletion:(CompletionBlock)completion;
@end
