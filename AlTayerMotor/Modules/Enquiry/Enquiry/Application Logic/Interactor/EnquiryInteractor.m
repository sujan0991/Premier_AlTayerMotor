//
//  EnquiryInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryInteractor.h"
#import "EnquiryDataManager.h"
#import "EnquiryNetwork.h"
#import "MResponse.h"

@interface EnquiryInteractor()
@property (nonatomic, strong) EnquiryDataManager *dataManager;
@property (nonatomic, strong) EnquiryNetwork *apiNetwork;
@end


@implementation EnquiryInteractor

- (instancetype)initWithDataManager:(EnquiryDataManager *)dataManager
                         andNetwork:(EnquiryNetwork *)network;
{
    if (self = [super init]) {
        self.dataManager = dataManager;
        self.apiNetwork = network;
    }
    
    return self;
}

- (void)findUserInfo
{
    MUser *user = [self.dataManager findUserInfo];
    [self.output foundUserInfo:user];
}

- (void)findBrands
{
    NSArray *brands = [self.dataManager findBrands];
    [self.output foundBrands:brands];
}

- (void)findPreownedBrands
{
    NSArray *brands = [self.dataManager findPreownedBrands];
    [self.output foundPreownedBrands:brands];
}

- (void)findModelsByBrand:(NSInteger)brandId
{
    NSArray *models = [self.dataManager findModelsByBrand:brandId];
    [self.output foundModels:models];
}

- (void)findPreownedModelsByBrand:(NSInteger)brandId
{
    NSArray *models = [self.dataManager findPreownedModelsByBrand:brandId];
    [self.output foundPreownedModels:models];
}

- (void)findEnquiries
{
    NSArray *enquiries = [self.dataManager findEnquiries];
    NSArray *vehicleEnquiries = [self.dataManager findVehicleEnquiries];
    [self.output foundEnquiries:enquiries
            andVehicleEnquiries:vehicleEnquiries];
}

- (void)postEnquiry:(MEnquiryRequest *)request
{
    [self.apiNetwork postEnquiry:request];
}

#pragma mark - network
- (void)networkError:(NSError *)error
{
    [self.output postEnquiryFailed];
}

- (void)networkDidLoad:(MResponse *)response inRequest:(MEnquiryRequest *)request
{
    MPayloadResult *payload = (MPayloadResult *)response.payload;
    if (payload && payload.success) {
        [self.output postEnquirySuccessWithRequest:request];
    } else {
        [self.output postEnquiryFailed];
    }
}

@end
