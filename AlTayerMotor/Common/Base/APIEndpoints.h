//
//  APIEndpoints.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#ifndef APIEndpoints_h
#define APIEndpoints_h

#define kURLHttpDomain  @"https://www.premier-motors.ae/"
#define kURLMethod  @"https://"

#ifdef DEBUG

#define kURLDomain  @"www.premier-motors.ae"

#else

#define kURLDomain  @"www.premier-motors.ae"
//#define kURLDomain  @"stg.altayermotors.com"

#endif

#define kURLBase            kURLMethod      kURLDomain
#define kEndpointToken          kURLBase        @"/episerverapi/token"

#define kAPI                kURLBase        @"/api"
#define kAPIVersion             kAPI            @"/v1"

#define kAPIBrands          kAPIVersion        @"/brands"
#define kAPIPreownedBrands  kAPIBrands         @"/pre-owned-brands"
#define kAPICities          kAPIVersion        @"/cities"
#define kAPILocations       kAPIVersion        @"/places"
#define kAPIBookingService  kAPIVersion        @"/service_bookings"
#define kAPIBookingTest     kAPIVersion        @"/test_drive_bookings"
#define kAPIInsurance       kAPIVersion        @"/insurances"
#define kAPIEnquiry         kAPIVersion        @"/enquiry"
#define kAPIDrivingExp      kAPIVersion        @"/drivingexperience"
#define kAPIGlobalSetting   kAPIVersion        @"/global_settings"
#define kAPIOffers          kAPIVersion        @"/offers"
#define kAPIOffersBrands    kAPIOffers         @"/brands"
#define kAPIOffersLatest    kAPIOffers         @"/latest"
#define kAPIOffersAll       kAPIOffers         @"/alloffers"

#endif /* APIEndpoints_h */
